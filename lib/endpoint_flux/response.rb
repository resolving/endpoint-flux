module EndpointFlux
  class Response
    def initialize(headers: {}, body: {})
      @body = body
      @headers = headers
    end

    attr_accessor :body, :headers, :redirect

    def success?
      body[:status].between?(200, 209)
    end

    def invalid?
      body[:status] == 422
    end

    def forbidden?
      body[:status] == 403
    end

    def unauthorized?
      body[:status] == 401
    end

    def not_found?
      body[:status] == 404
    end

    def redirected?
      !!redirect
    end

    def redirect_to(*options)
      redirect = options
    end
  end
end
