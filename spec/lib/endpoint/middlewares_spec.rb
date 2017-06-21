require 'spec_helper'

RSpec.describe EndpointFlux::Endpoint do
  let(:klass) { class_double('Sample') }

  before do
    EndpointFlux.config EndpointFlux::Config.new

    klass.include EndpointFlux::Endpoint
  end

  context 'with exceptions' do
    it 'fails with wrong string' do
      klass.flow [:validator]

      expect do
        klass.validator 'some_not_existing_class'
      end.to raise_error('You must provide block or existing klass')
    end

    it 'fails whit wrong class passed' do
      stub_const 'EndpointFlux::Middlewares::Validator::SampleMiddleware', Class.new

      klass.flow [:validator]

      expect { klass.validator 'sample_middleware' }.to raise_error(
        'The [EndpointFlux::Middlewares::Validator::SampleMiddleware] '\
        'class should define perform class method'
      )
    end

    context 'when wrong param passed' do
      it do
        klass.flow [:validator]

        expect { klass.validator 1334 }.to raise_error(
          'You must provide block or existing klass'
        )
      end

      it do
        stub_const 'SampleMiddleware', Class.new

        klass.flow [:validator]

        expect { klass.validator SampleMiddleware }.to raise_error(
          'You must provide block or existing klass'
        )
      end
    end
  end

  describe 'middlewares' do
    before do
      stub_const 'SomeNamespace::MiddlewareName::SampleMiddleware', Class.new
      SomeNamespace::MiddlewareName::SampleMiddleware.class_eval do
        def self.perform(*args)
          args
        end
      end

      EndpointFlux.config.middlewares_namespaces << 'some_namespace'
    end

    before do
      klass.flow [:middleware_name]
    end

    let(:middleware) { klass.middleware_name.first }

    it 'sets middleware with options' do
      klass.middleware_name 'sample_middleware', some: :option

      expect(middleware.klass).to be(SomeNamespace::MiddlewareName::SampleMiddleware)
      expect(middleware.options).to eq(some: :option)
    end

    it 'sets middleware' do
      klass.middleware_name 'sample_middleware'

      expect(middleware.klass).to be(SomeNamespace::MiddlewareName::SampleMiddleware)
    end

    it 'does not add twice' do
      klass.middleware_name 'sample_middleware'
      klass.middleware_name 'sample_middleware'

      middleware = klass.middleware_name.first

      expect(middleware.klass).to be(SomeNamespace::MiddlewareName::SampleMiddleware)
    end

    context 'block' do
      let(:block) { proc {} }

      it 'sets middleware' do
        klass.middleware_name(&block)

        expect(middleware.handler).to be == block
      end

      it 'does not adds twice' do
        klass.middleware_name(&block)
        klass.middleware_name(&block)

        expect(middleware.handler).to be == block
      end
    end
  end
end
