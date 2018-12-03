require 'spec_helper'

RSpec.describe EndpointFlux::Config::Interceptor do
  describe '#add' do
    context 'when wrong params given' do
      it 'fails when no block given' do
        expect { subject.add() }.to raise_error('Block not given')
      end
    end

    context 'when valid params given' do
      let(:block) { proc {} }

      it 'adds the handler' do
        subject.add(&block)

        expect(subject.handlers).to include(block)
      end
    end
  end

  describe '#run' do
    let(:sample_exception) { stub_const 'SampleException', Class.new(Exception) }
    let(:block) { proc { raise SampleException } }

    context 'when valid params given' do
      it 'runs the handler' do
        subject.add(&block)
        expect { subject.run('attrs') }
          .to raise_error(sample_exception)
      end
    end
  end
end
