module EndpointFlux
  module Middlewares
    module Decorator
      module Skip
        def self.perform(*args, _options)
          args
        end
      end
    end
  end
end
