require 'spec_helper'

RSpec.describe EndpointFlux::Config::Middleware do
  let(:block) { proc { raise BlockException, 'bla bla' } }
  let(:options) { { option: :option } }

  before do
    stub_const 'BlockException', Class.new(Exception)
    stub_const 'PerformException', Class.new(Exception)
    stub_const 'MiddlewareSample', Class.new

    MiddlewareSample.class_eval do
      def self.perform(*)
        raise PerformException, 'bla bla'
      end
    end
  end

  context 'when wrong params given' do
    it 'fails when there is no params given' do
      expect { described_class.new }.to raise_error('You must provide block or existing klass')
    end

    it 'fails when there is no perform method' do
      stub_const 'NoPerformMiddlewareSample', Class.new

      expect do
        described_class.new(NoPerformMiddlewareSample)
      end.to raise_error('The [NoPerformMiddlewareSample] class should define perform class method')
    end
  end

  context 'when valid params given' do
    let(:subject) { described_class.new(MiddlewareSample, options, &block) }

    it 'creates middleware instance with class' do
      expect(subject.klass).to be(MiddlewareSample)
    end

    it 'creates middleware instance with handler' do
      expect(subject.handler).to be(block)
    end

    it 'creates middleware instance with options' do
      expect(subject.options).to be(options)
    end
  end

  describe '#run' do
    it 'runs klass perform when it is given' do
      middleware = described_class.new(MiddlewareSample)

      expect { middleware.run({}) }.to raise_error(PerformException)
    end

    it 'runs klass handler when it is given' do
      middleware = described_class.new(&block)

      expect { middleware.run({}) }.to raise_error(BlockException)
    end
  end
end
