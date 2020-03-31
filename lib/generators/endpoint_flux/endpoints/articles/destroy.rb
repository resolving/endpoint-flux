module Endpoints
  module Articles
    module Destroy
      include EndpointFlux::Endpoint

      validator :inline do
        required(:id).value(:number?)
      end

      process do |request, response|
        article = Article.find(request.params[:id]).destroy

        response.body[:article] = article

        [request, response]
      end

      decorator :add_status, 202
      decorator :representable,
                decorator: 'Articles::Base', wrapped_in: :article
    end
  end
end
