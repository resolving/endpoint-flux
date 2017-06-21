require 'spec_helper'

RSpec.describe EndpointFlux::Config::RescueFrom do
  describe '#add' do
    let(:sample_exception) { stub_const 'SampleException', Class.new(Exception) }

    context 'when wrong params given' do
      it 'fails when no block given' do
        expect { subject.add(sample_exception) }.to raise_error('Block not given')
      end
    end

    context 'when valid params given' do
      let(:block) { proc {} }

      it 'adds the exception handler' do
        subject.add(sample_exception, &block)

        expect(subject.exceptions).to include(sample_exception)
        expect(subject.handlers.values).to include(block)
      end
    end
  end

  describe '#run' do
    let(:sample_exception) { stub_const 'SampleException', Class.new(Exception) }
    let(:block_exception) { stub_const 'BlockException', Class.new(Exception) }
    let(:block) { proc { raise BlockException } }

    context 'when wrong params given' do
      it 'fails when handler not given' do
        expect { subject.run('name', 'attrs', sample_exception.new) }
          .to raise_error('No handler given')
      end
    end

    context 'when valid params given' do
      it 'runs the handler' do
        subject.add(sample_exception, &block)
        expect { subject.run('name', 'attrs', sample_exception.new) }
          .to raise_error(block_exception)
      end
    end
  end
end
