require 'bigdecimal'

module Validations
  module Predicates
    module Decimal
      module Methods
        def decimal?(input)
          begin
            true if BigDecimal(input)
          rescue ArgumentError, TypeError
            false
          end
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
