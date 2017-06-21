module EndpointFlux
  module Exceptions
    class NotFound < EndpointFlux::Exceptions::Base
      def to_hash
        {
          status: 404,
          message: 'not found'
        }
      end
    end
  end
end
