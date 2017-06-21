RSpec.describe EndpointFlux::Middlewares::Validator::Empty do
  describe '#perform' do
    let(:params) { { some: 'value' } }
    let(:request) { EndpointFlux::Request.new(headers: {}, params: params) }
    let(:response) { EndpointFlux::Response.new }

    it 'returns empty params' do
      middleware_request, middleware_response = subject.perform(request, response, {})

      expect(middleware_request.params).to eq({})
      expect(middleware_response.headers).to eq({})
      expect(middleware_response.body).to eq({})
    end
  end
end
