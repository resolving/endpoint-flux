module EndpointFlux
  module Middlewares
    module Authenticator
      module Skip
        def self.perform(*args, _options)
          args
        end
      end
    end
  end
end
