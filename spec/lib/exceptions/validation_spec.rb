require 'spec_helper'

RSpec.describe EndpointFlux::Exceptions::Validation do
  describe '#to_hash' do
    let(:messages) { {name: 'not valid'} }
    it 'returns correct hash' do
      expect(EndpointFlux::Exceptions::Validation.new(messages).to_hash).to eq(
        status: 422,
        message: 'validation errors',
        errors: messages
      )
    end
  end
end
