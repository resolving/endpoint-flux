require 'spec_helper'

RSpec.describe EndpointFlux::Endpoint do
  let(:klass) { stub_const 'Sample', Class.new }

  before do
    klass.include EndpointFlux::Endpoint
  end

  describe '#flow' do
    let(:params) { { some: :val } }
    let(:middleware_request) { EndpointFlux::Request.new(headers: {}, params: params) }
    let(:middleware_response) { EndpointFlux::Response.new }

    before do
      stub_const('EndpointFlux::Middlewares::Validator::Sample', Class.new)
      EndpointFlux::Middlewares::Validator::Sample.class_eval do
        def self.perform(request, response, _)
          request.params = {}
          [request, response]
        end
      end

      stub_const('EndpointFlux::Middlewares::Decorator::Sample', Class.new)
      EndpointFlux::Middlewares::Decorator::Sample.class_eval do
        def self.perform(request, _response, _)
          [request, EndpointFlux::Response.new(headers: {}, body: {})]
        end
      end

      klass.flow %i[validator decorator]

      EndpointFlux.config.default_middlewares :validator, :sample
      EndpointFlux.config.default_middlewares :decorator, 'sample'
    end

    it 'uses default middleware if not defined' do
      request, response = klass.perform(middleware_request)
      expect(request.params).to eq({})
      expect(response.body).to eq({})
    end
  end
end
