module EndpointFlux
  module Exceptions
    class Base < StandardError
      attr_accessor :messages

      def initialize(messages = nil)
        @messages = messages

        super("#{self.class.name}: [ #{messages.inspect}]")
      end

      def to_hash
        raise NotImplementedError
      end

      def inspect
        "#{self.class.name}: [ #{to_hash.inspect} ]"
      end
    end
  end
end
