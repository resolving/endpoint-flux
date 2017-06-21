require 'spec_helper'

RSpec.describe EndpointFlux::Config do
  describe '#endpoints_namespace' do
    it 'sets default endpoints namespace' do
      stub_const 'Some::Sample', Class.new

      subject.endpoints_namespace 'some/sample'

      expect(subject.endpoints_namespace).to be == 'some/sample'
    end
  end
end
