module EndpointFlux
  class Config
    class Interceptor
      attr_accessor :handlers

      def initialize
        @handlers = []
      end

      def run(attrs)
        handlers.each { |handler| handler.call(attrs) }

        attrs
      end

      def add(&block)
        raise 'Block not given' unless block_given?

        handlers << block
      end
    end
  end
end
