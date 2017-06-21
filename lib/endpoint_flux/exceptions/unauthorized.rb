module EndpointFlux
  module Exceptions
    class Unauthorized < EndpointFlux::Exceptions::Base
      def to_hash
        {
          status: 401,
          message: 'Unauthorized'
        }
      end
    end
  end
end
