module EndpointFlux
  module Exceptions
    class Validation < EndpointFlux::Exceptions::Base
      def to_hash
        {
          status: 422,
          message: 'validation errors',
          errors: @messages
        }
      end
    end
  end
end
