module EndpointFlux
  class Config
    require 'endpoint_flux/config/interceptor'
    require 'endpoint_flux/config/middleware'
    require 'endpoint_flux/config/rescue_from'

    attr_accessor :middlewares_namespaces

    def initialize
      @flow                   = %i[authenticator authorizator validator policy process decorator]
      @default_middlewares    = {}
      @rescue_from            = EndpointFlux::Config::RescueFrom.new
      @endpoints_namespace    = 'endpoints'
      @middlewares_namespaces = ['endpoint_flux/middlewares']
    end

    def interceptor(&block)
      @interceptor ||= EndpointFlux::Config::Interceptor.new
      @interceptor.add(&block) if block_given?
      @interceptor
    end

    def flow(new_flow = nil)
      @flow = new_flow if new_flow

      @flow
    end

    def default_middlewares(name = nil, klass_name = nil)
      if name
        @default_middlewares[name] ||= []

        if klass_name
          klass = fetch_middleware_class!(name.to_s, klass_name.to_s)
          @default_middlewares[name] << EndpointFlux::Config::Middleware.new(klass)
        end

        return @default_middlewares[name]
      end

      @default_middlewares
    end

    def rescue_from(klass_names = nil, &block)
      if klass_names
        if klass_names.respond_to?(:to_ary)
          klass_names.to_ary || [klass_names]
        else
          [klass_names]
        end.each do |klass_name|
          klass = EndpointFlux::ClassLoader.load_class!(klass_name)
          @rescue_from.add(klass, &block)
        end
      end

      @rescue_from
    end

    def endpoints_namespace(name = nil)
      @endpoints_namespace = name if name

      @endpoints_namespace
    end

    def fetch_middleware_class!(name, klass_name)
      klass = fetch_middleware_class(name, klass_name)

      raise "The [#{klass_name}] should be a string representing a class" unless klass

      klass
    end

    def fetch_middleware_class(name, klass_name)
      middlewares_namespaces.each do |namespace|
        klass = EndpointFlux::ClassLoader.load_class(
          [namespace, name.to_s, klass_name.to_s].compact.join('/')
        )

        return klass if klass
      end

      nil
    end
  end
end
