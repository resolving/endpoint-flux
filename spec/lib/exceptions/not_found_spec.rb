require 'spec_helper'

RSpec.describe EndpointFlux::Exceptions::NotFound do
  describe '#to_hash' do
    it 'returns correct hash' do
      expect(subject.to_hash).to eq(
        status: 404,
        message: 'not found'
      )
    end
  end
end
