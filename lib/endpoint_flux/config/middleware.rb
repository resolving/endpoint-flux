module EndpointFlux
  class Config
    class Middleware
      attr_accessor :klass, :options, :handler

      def initialize(klass = nil, options = {}, &block)
        if klass
          unless klass.methods.include?(:perform)
            raise "The [#{klass}] class should define perform class method"
          end
        else
          raise 'You must provide block or existing klass' unless block_given?
        end

        @klass   = klass
        @options = options
        @handler = block
      end

      def run(attrs)
        if klass
          klass.perform(*attrs, options, &handler)
        elsif handler
          handler.call(*attrs, options)
        else
          raise "Unknown middleware type [#{inspect}]"
        end
      end

      def ==(other)
        return true if klass && klass == other.klass
        return true if handler && handler == other.handler

        false
      end
    end
  end
end
