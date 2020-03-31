module Validations
  module Predicates
    module Base
      include Dry::Logic::Predicates
      include Validations::Predicates::Password
      include Validations::Predicates::Email
      include Validations::Predicates::Bool
      include Validations::Predicates::Dates
      include Validations::Predicates::Decimal
    end
  end
end
