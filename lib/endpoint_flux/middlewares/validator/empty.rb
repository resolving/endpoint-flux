module EndpointFlux
  module Middlewares
    module Validator
      module Empty
        def self.perform(request, response, _options)
          request.params = {}
          [request, response]
        end
      end
    end
  end
end
