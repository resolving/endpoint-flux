require 'spec_helper'

RSpec.shared_context 'perform does not change the params', shared_context: :metadata do
  describe '#perform' do
    let(:params) { { some: 'value' } }
    let(:headers) { { 'Authorization' => 'valid' } }
    let(:request) { EndpointFlux::Request.new(headers: headers, params: params) }
    let(:response) { EndpointFlux::Response.new(headers: {}, body: {}) }
    
    it 'returns not changed params' do
      middleware_request, middleware_response = subject.perform(request, response, {})
      
      expect(middleware_request.params).to eq(params)
      expect(middleware_request.headers).to eq(headers)
      expect(middleware_response.headers).to eq({})
      expect(middleware_response.body).to eq({})
    end
  end
end
