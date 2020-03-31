module Endpoints
  module Tasks
    module Destroy
      include EndpointFlux::Endpoint

      validator :inline do
        required(:id).value(:number?)
      end

      process do |request, response|
        task = Task.find(request.params[:id]).destroy

        response.body[:task] = task

        [request, response]
      end

      decorator :add_status, 202
      decorator :representable,
                decorator: 'Tasks::Base', wrapped_in: :task
    end
  end
end
