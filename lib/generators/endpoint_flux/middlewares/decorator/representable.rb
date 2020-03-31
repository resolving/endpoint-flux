module Middlewares
  module Decorator
    module Representable
      def self.perform(request, response, options)
        resource_name = options[:wrapped_in] || options[:decorator]
        resource      = response.body[resource_name]

        response.body[resource_name] = decorate(resource, options) if resource

        [request, response]
      end

      def self.decorate(object, options)
        decorator = "::Decorators::#{options[:decorator].to_s.camelize}".constantize

        if options[:collection?]
          decorator.for_collection.new(object.to_a).to_hash
        else
          decorator.new(object).to_hash
        end
      end
    end
  end
end
