module EndpointFlux
  class Request
    def initialize(headers: {}, params: {}, namespace: nil)
      @headers = headers
      @params = params
      @namespace = namespace
    end

    attr_accessor :params
    attr_accessor :headers
    attr_accessor :namespace
    attr_accessor :endpoint
    attr_accessor :scope
  end
end
