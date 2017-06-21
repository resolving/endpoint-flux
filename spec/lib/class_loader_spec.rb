require 'spec_helper'

RSpec.describe EndpointFlux::ClassLoader do
  describe '#string_to_class_name' do
    it 'converts string to class name' do
      expect(subject.string_to_class_name('hey/bey/cey')).to eq('Hey::Bey::Cey')
    end
  end

  describe '#load_class!' do
    context 'when wrong params given' do
      it 'fails if the class is not existing' do
        expect { subject.load_class!('hey/bey') }
          .to raise_error('The [hey/bey] should be a string representing a class')
      end

      it 'fails if the class name is invalid' do
        expect { subject.load_class!('111/bey') }
          .to raise_error('The [111/bey] should be a string representing a class')
      end
    end

    context 'when valid params given' do
      let(:sample_class) { stub_const 'SampleClass::SecondLevel', Class.new }

      it 'returns the class back' do
        expect(subject.load_class!(sample_class)).to be(sample_class)
      end
    end
  end
end
