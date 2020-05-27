require 'securerandom'

module EndpointFlux
  class Request
    def initialize(headers: {}, remote_ip: '', params: {}, namespace: nil, trace_id: nil)
      @headers = headers
      @remote_ip = remote_ip
      @params = params
      @namespace = namespace
      @trace_id = trace_id || SecureRandom.hex(32)
    end

    attr_accessor :params
    attr_accessor :headers
    attr_accessor :remote_ip
    attr_accessor :namespace
    attr_accessor :endpoint
    attr_accessor :scope
    attr_accessor :trace_id
  end
end
