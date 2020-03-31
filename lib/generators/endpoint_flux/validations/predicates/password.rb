module Validations
  module Predicates
    module Password
      module Methods
        def password?(value)
          rules = [
            %r{[A-Z]}, # at least 1 uppercase character (A-Z)
            %r{[a-z]}, # at least 1 lowercase character (a-z)
            %r{\d},    # at least 1 digit (0-9)
            %r{\W}     # at least 1 special character (punctuation)
          ]

          matches = rules.inject(0) do |n, rule|
            value.match(rule) ? n + 1 : n
          end

          matches >= 3
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
