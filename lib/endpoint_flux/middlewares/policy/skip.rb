module EndpointFlux
  module Middlewares
    module Policy
      module Skip
        def self.perform(*args, _options)
          args
        end
      end
    end
  end
end
