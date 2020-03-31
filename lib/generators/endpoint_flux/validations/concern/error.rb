module Validations
  module Error
    def raise_validation_error(errors)
      raise EndpointFlux::Exceptions::Validation, errors
    end
  end
end
