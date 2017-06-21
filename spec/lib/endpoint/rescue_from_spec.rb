require 'spec_helper'

RSpec.describe EndpointFlux::Endpoint do
  let(:klass) { stub_const 'Sample', Class.new }
  let(:middleware_request) { EndpointFlux::Request.new(headers: {}, params: {}) }
  let(:middleware_response) { EndpointFlux::Response.new }

  before do
    EndpointFlux.config EndpointFlux::Config.new

    klass.include EndpointFlux::Endpoint
  end

  describe '#rescue_from' do
    let(:sample_exception) { stub_const 'SampleException', Class.new(Exception) }
    let!(:sample_validator) do
      stub_const 'EndpointFlux::Middlewares::Validator::Sample', Class.new
      EndpointFlux::Middlewares::Validator::Sample.class_eval do
        def self.perform(*)
          raise SampleException, 'bla bla'
        end
      end
      EndpointFlux::Middlewares::Validator::Sample
    end
    let!(:sample_decorator) do
      stub_const 'EndpointFlux::Middlewares::Decorator::Sample', Class.new
      EndpointFlux::Middlewares::Decorator::Sample.class_eval do
        def self.perform(request, response, options)
          response.body[:decorator] = true
          [request, response, options]
        end
      end
      EndpointFlux::Middlewares::Decorator::Sample
    end

    it 'fails if exception not found' do
      expect do
        EndpointFlux.config.rescue_from 'NonExsistingClasss' do |_, attrs|
          # code
        end
      end.to raise_error('The [NonExsistingClasss] should be a string representing a class')
    end

    context 'default middleware' do
      before do
        klass.flow %i[validator decorator]
        klass.validator 'sample'
        klass.decorator 'sample'

        EndpointFlux.config.rescue_from sample_exception do |_, attrs|
          [attrs[0], attrs[1], { status: false }]
        end
      end

      it 'uses default if not defined' do
        _, response = klass.perform(middleware_request)
        expect(response.body[:status]).to be_falsey
      end
    end
  end
end
