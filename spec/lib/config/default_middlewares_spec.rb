require 'spec_helper'

RSpec.describe EndpointFlux::Config do
  describe '#default_middlewares' do
    before do
      stub_const('EndpointFlux::Middlewares::Authenticator::Sample', Class.new)
      EndpointFlux::Middlewares::Authenticator::Sample.class_eval do
        def self.perform(_, headers, response)
          [{}, headers, response]
        end
      end

      subject.default_middlewares :authenticator, 'sample'
    end
    let(:middleware) { subject.default_middlewares[:authenticator].first }

    it 'sets default middleware' do
      expect(middleware.klass).to be(EndpointFlux::Middlewares::Authenticator::Sample)
    end
  end
end
