module Endpoints
  module Tasks
    module Create
      include EndpointFlux::Endpoint

      validator :inline do
        required(:title).value(:str?)
        required(:article_id).value(:number?)
      end

      process do |request, response|
        task = Task.create!(
          title: request.params[:title],
          article_id: request.params[:article_id]
        )

        response.body[:task] = task

        [request, response]
      end

      decorator :add_status, 201
      decorator :representable,
                decorator: 'Tasks::Base', wrapped_in: :task
    end
  end
end
