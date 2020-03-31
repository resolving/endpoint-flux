module Endpoints
  module Articles
    module Create
      include EndpointFlux::Endpoint

      validator :inline do
        required(:name).value(:str?)
        required(:board_id).value(:number?)
      end

      process do |request, response|
        article = Article.create!(
          name: request.params[:name],
          board_id: request.params[:board_id]
        )

        response.body[:article] = article

        [request, response]
      end

      decorator :add_status, 201
      decorator :representable,
                decorator: 'Articles::Base', wrapped_in: :article
    end
  end
end
