module Endpoints
  module Tasks
    module Update
      include EndpointFlux::Endpoint

      validator :inline do
        required(:id).value(:number?)
        required(:title).value(:str?)
        required(:article_id).value(:number?)
      end

      process do |request, response|
        Task.find(request.params[:id]).update(
          title: request.params[:title],
          article_id: request.params[:article_id]
        )

        response.body[:task] = Task.find(request.params[:id])

        [request, response]
      end

      decorator :add_status, 201
      decorator :representable,
                decorator: 'Tasks::Base', wrapped_in: :task
    end
  end
end
