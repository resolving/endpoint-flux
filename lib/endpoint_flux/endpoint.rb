require 'endpoint_flux/config'
require 'endpoint_flux/request'
require 'endpoint_flux/response'

module EndpointFlux
  module Endpoint
    def self.included(includer)
      includer.extend self
      includer.class_eval %( @middlewares ||= {} )
    end

    def perform(request)
      attrs = [request, EndpointFlux::Response.new]
      attrs = EndpointFlux.config.interceptor.run(attrs)

      request.endpoint = to_s

      flow.inject(attrs) do |res, middleware_name|
        fetch_middleware(middleware_name).inject(res) do |middleware_res, middleware|
          middleware.run(middleware_res)
        end
      end
    rescue *EndpointFlux.config.rescue_from.exceptions => e
      EndpointFlux.config.rescue_from.run(name, attrs, e)
    end

    def flow(array = nil)
      @flow = array.map(&:to_sym) if array
      @flow || EndpointFlux.config.flow
    end

    def method_missing(method_id, *attrs, &block)
      method_sym = method_id.to_sym
      if flow.include?(method_sym)
        configure_middleware(method_sym, attrs, &block)
      else
        super
      end
    end

    def respond_to_missing?(method_name)
      flow.include?(method_name.to_sym)
    end

    private

    def configure_middleware(middleware_name, attrs, &block)
      @middlewares[middleware_name] ||= []

      middleware = build_middleware(middleware_name, *attrs, &block)
      if middleware && !@middlewares[middleware_name].include?(middleware)
        @middlewares[middleware_name] << middleware
      end

      @middlewares[middleware_name]
    end

    def fetch_middleware(name)
      @middlewares[name] ||
        EndpointFlux.config.default_middlewares[name] ||
        raise("No middleware registred for [#{name.inspect}]")
    end

    def build_middleware(middleware_name, *options, &block)
      attrs = []
      unless options.empty?
        klass = EndpointFlux.config.fetch_middleware_class(middleware_name, options.first)

        if klass
          attrs << klass
          attrs << options[1..-1]
        else
          attrs << nil
          attrs << options
        end
      end

      return if attrs.empty? && !block_given?

      EndpointFlux::Config::Middleware.new(*attrs.flatten, &block)
    end
  end
end
