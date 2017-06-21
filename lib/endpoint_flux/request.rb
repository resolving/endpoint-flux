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
    attr_accessor :current_user_params
    attr_accessor :scope

    def current_user
      @current_user ||= begin
        if current_user_params && current_user_params['id']
          User[current_user_params['id']]
        end
      end
    end
  end
end
