module Validations
  module Predicates
    module Dates
      module Methods
        def in_past?(value)
          value && ::Rich::Date.safe_parse(value).try(:past?)
        end

        def in_future?(value)
          !self[:in_past?].call(value)
        end

        def earlier_then?(v1, v2)
          v1 && v2 && ::Rich::Date.safe_parse(v1) > ::Rich::Date.safe_parse(v2)
        end

        def on_or_later_then?(v1, v2)
          !self[:earlier_then?].call(v1, v2)
        end

        def parsed_as_date?(value)
          value.nil? || !Validations::Types::Form::DateTime[value].is_a?(String)
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
