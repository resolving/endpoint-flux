require 'spec_helper'

RSpec.describe EndpointFlux::Endpoint do
  let(:klass) { stub_const 'Sample', Class.new }
  let(:middleware_request) { EndpointFlux::Request.new(headers: {}, params: params) }
  let(:middleware_response) { EndpointFlux::Response.new }

  before do
    EndpointFlux.config EndpointFlux::Config.new

    klass.include EndpointFlux::Endpoint
  end

  describe '#perform' do
    before do
      stub_const 'EndpointFlux::Middlewares::Validator::SampleValidator', Class.new
      EndpointFlux::Middlewares::Validator::SampleValidator.class_eval do
        def self.perform(request, response, _)
          request.params = {}
          [request, response, {}]
        end
      end
    end

    let(:params) { { some: :val } }

    it 'checks if middleware exists' do
      klass.flow [:validator]

      expect { klass.perform(middleware_request) }
        .to raise_error('No middleware registred for [:validator]')
    end

    context 'middleware passed as string' do
      it 'runs middleware passed as string' do
        klass.flow [:validator]
        klass.validator 'sample_validator'

        request, response = klass.perform(middleware_request)

        expect(request.params).to eq({})
        expect(response.body).to eq({})
      end
    end

    context 'default middleware' do
      before do
        klass.flow [:validator]

        EndpointFlux.config.default_middlewares :validator, 'sample_validator'
      end

      it 'uses default if not defined' do
        request, response = klass.perform(middleware_request)

        expect(request.params).to eq({})
        expect(response.body).to eq({})
      end
    end
  end
end
