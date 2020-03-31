module Endpoints
  module Articles
    module Index
      include EndpointFlux::Endpoint

      authorizator :skip

      validator :inline do
        required(:board_id).value(:number?)
      end

      process do |request, response|

        response.body[:articles] = Article.where(board_id: request.params[:board_id])

        [request, response]
      end

      decorator :add_status, 200
      decorator :paginate, wrapped_in: :articles
      decorator :representable, decorator: 'Articles::Base',
                collection?: true,
                wrapped_in: :articles
    end
  end
end
