module ActiveSupport
  module Concern ; end
end

require 'spec_helper'
require 'endpoint_flux/rails/concerns/endpoint_controller'
require 'ostruct'

class RemoteIpDummyClass
  include EndpointFlux::Rails::Concerns::EndpointController

  def headers
    {}
  end

  def request
    OpenStruct.new(
      headers: { 'authorization' => 'authorization header' },
      remote_ip: '172.18.0.1',
      env: { 'HTTP_X_FORWARDED_FOR' => '172.18.0.2' }
    )
  end
end

class LocalIpDummyClass
  include EndpointFlux::Rails::Concerns::EndpointController

  def headers
    {}
  end

  def request
    OpenStruct.new(
      headers: { 'authorization' => 'authorization header' },
      remote_ip: '127.0.0.1',
      env: { 'HTTP_X_FORWARDED_FOR' => '172.18.0.2' }
    )
  end

  def params; end

end

RSpec.describe EndpointFlux::Rails::Concerns::EndpointController do
  describe '#request_object' do
    before do
      allow(subject).to receive(:endpoint_params).and_return({})
    end

    context 'remote ip' do
      subject { RemoteIpDummyClass.new }

      it 'sets property as remote_ip' do
        expect(
          ::EndpointFlux::Request
        ).to receive(:new).with(headers: { 'Authorization' => 'authorization header' },
                                params: subject.endpoint_params,
                                remote_ip: subject.request.remote_ip)

        subject.request_object
      end
    end

    context 'local ip' do
      subject { LocalIpDummyClass.new }

      it 'sets property as HTTP_X_FORWARDED_FOR' do
        expect(
          ::EndpointFlux::Request
        ).to receive(:new).with(headers: { 'Authorization' => 'authorization header' },
                                params: subject.endpoint_params,
                                remote_ip: subject.request.env['HTTP_X_FORWARDED_FOR'])

        subject.request_object
      end
    end

  end

  describe '#endpoint_params' do
    before do
      allow(subject).to receive_message_chain(:params, :permit!, :except, :to_h, :deep_symbolize_keys)
                            .and_return({test: 'test'})
    end

    context 'request' do
      subject { LocalIpDummyClass.new }
      it 'permits and excepts params' do
        expect(subject.endpoint_params).to match({test: 'test'})
      end
    end

  end
end
