module Validations
  module Predicates
    module Bool
      module Methods
        def bool?(value)
          ![true, false, 'true', 'false', '0', '1'].find do |item|
            value == item
          end.nil?
        end
      end

      extend Methods

      def self.included(other)
        super
        other.extend(Methods)
      end
    end
  end
end
