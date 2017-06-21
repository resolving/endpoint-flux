require 'spec_helper'

RSpec.describe EndpointFlux::Exceptions::Forbidden do
  describe '#to_hash' do
    it 'returns correct hash' do
      expect(subject.to_hash).to eq(
        status: 403,
        message: 'Forbidden'
      )
    end
  end
end
