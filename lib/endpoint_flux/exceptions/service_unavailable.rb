module EndpointFlux
  module Exceptions
    class ServiceUnavailable < EndpointFlux::Exceptions::Base
      def to_hash
        {
          status: 503,
          message: 'service unavailable'
        }
      end
    end
  end
end
