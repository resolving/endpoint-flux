RSpec.describe EndpointFlux::Middlewares::Decorator::AddStatus do
  describe '#perform' do
    let(:params) { { some: 'value' } }
    let(:body) { { status: 200 } }
    let(:request) { EndpointFlux::Request.new(headers: {}, params: params) }
    let(:response) { EndpointFlux::Response.new(headers: {}, body: body) }

    it 'returns response with status in body' do
      middleware_request, middleware_response = subject.perform(request, response, {})

      expect(middleware_request.headers).to eq({})
      expect(middleware_request.params).to eq(params)
      expect(middleware_response.headers).to eq({})
      expect(middleware_response.body).to eq(body)
    end
  end
end
