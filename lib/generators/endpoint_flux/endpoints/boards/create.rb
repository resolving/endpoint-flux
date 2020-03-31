#
module Endpoints
  module Boards
    module Create
      include EndpointFlux::Endpoint

      validator :inline do
        required(:name).value(:str?)
      end

      process do |request, response|
        link = SecureRandom.hex(20)
        board = Board.create!(name: request.params[:name], link: link)

        response.body[:board] = board

        [request, response]
      end

      decorator :add_status, 201
      decorator :representable, decorator: 'Boards::Base', wrapped_in: :board
    end
  end
end
