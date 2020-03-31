module Endpoints
  module Boards
    module Index
      include EndpointFlux::Endpoint

      authorizator :skip

      process do |request, response|

        response.body[:boards] = Board.all

        [request, response]
      end

      decorator :add_status, 200
      decorator :representable, decorator: 'Boards::Base',
                collection?: true,
                wrapped_in: :boards
    end
  end
end
