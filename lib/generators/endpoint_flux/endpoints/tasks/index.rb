module Endpoints
  module Tasks
    module Index
      include EndpointFlux::Endpoint

      authorizator :skip

      validator :inline do
        required(:article_id).value(:number?)
      end

      process do |request, response|

        response.body[:tasks] = Task.where(article_id: request.params[:article_id])

        [request, response]
      end

      decorator :add_status, 200
      decorator :representable, decorator: 'Tasks::Base',
                collection?: true,
                wrapped_in: :tasks
    end
  end
end
