module EndpointFlux
  class Config
    class RescueFrom
      attr_accessor :handlers, :exceptions

      def initialize
        @handlers   = {}
        @exceptions = []
      end

      def run(name, attrs, e)
        raise 'No handler given' unless exceptions.include?(e.class)

        handlers[e.class.name].call(name, attrs, e)
      end

      def add(klass, &block)
        raise 'Block not given' unless block_given?

        handlers[klass.to_s] = block

        exceptions << klass unless exceptions.include?(klass)

        nil
      end
    end
  end
end
