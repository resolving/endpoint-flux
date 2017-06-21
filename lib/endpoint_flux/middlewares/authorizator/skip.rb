module EndpointFlux
  module Middlewares
    module Authorizator
      module Skip
        def self.perform(*args, _opts)
          args
        end
      end
    end
  end
end
