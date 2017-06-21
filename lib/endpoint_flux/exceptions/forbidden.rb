module EndpointFlux
  module Exceptions
    class Forbidden < EndpointFlux::Exceptions::Base
      def to_hash
        {
          status: 403,
          message: 'Forbidden'
        }
      end
    end
  end
end
