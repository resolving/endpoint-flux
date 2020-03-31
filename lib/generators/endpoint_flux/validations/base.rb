require 'dry-validation'
require 'dry-types'

module Validations
  module Types
    include Dry::Types.module
  end

  class Base < Dry::Validation::Schema
    configure do
      predicates(Validations::Predicates::Base)

      config.input_processor = :sanitizer
      config.messages_file   = 'config/locales/en/validation-errors.yml'
    end
    define! do
      optional(:page).value(:number?)
      optional(:per_page) { number? | eql?('all') }
    end
  end
end
