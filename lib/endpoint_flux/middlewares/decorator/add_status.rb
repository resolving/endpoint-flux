module EndpointFlux
  module Middlewares
    module Decorator
      module AddStatus
        def self.perform(request, response, status)
          response.body[:status] = status
          [request, response]
        end
      end
    end
  end
end
