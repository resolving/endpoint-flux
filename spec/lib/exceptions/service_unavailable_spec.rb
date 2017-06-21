require 'spec_helper'

RSpec.describe EndpointFlux::Exceptions::ServiceUnavailable do
  describe '#to_hash' do
    it 'returns correct hash' do
      expect(subject.to_hash).to eq(
        status: 503,
        message: 'service unavailable'
      )
    end
  end
end
