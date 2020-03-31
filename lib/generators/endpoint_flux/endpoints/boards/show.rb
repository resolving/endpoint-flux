module Endpoints
  module Boards
    module Show
      include EndpointFlux::Endpoint

      authorizator :skip

      validator :inline do
        required(:link).value(:str?)
      end
      process do |request, response|

        response.body[:board] = Board.find_by(link: request.params[:link])

        [request, response]
      end

      decorator :add_status, 200
      decorator :representable, decorator: 'Boards::Show',
                 wrapped_in: :board
    end
  end
end
