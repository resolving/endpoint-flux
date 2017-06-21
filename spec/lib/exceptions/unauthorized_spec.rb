require 'spec_helper'

RSpec.describe EndpointFlux::Exceptions::Unauthorized do
  describe '#to_hash' do
    it 'returns correct hash' do
      expect(subject.to_hash).to eq(
        status: 401,
        message: 'Unauthorized'
      )
    end
  end
end
