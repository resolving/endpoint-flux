module ActiveSupport
  module Concern; end
end

module Endpoints
  module Test; end
end

class String
  def camelize(uppercase_first_letter = true)
    string = self
    if uppercase_first_letter
      string = string.sub(/^[a-z\d]*/) { |match| match.capitalize }
    else
      string = string.sub(/^(?:(?=\b|[A-Z_])|\w)/) { |match| match.downcase }
    end
    string.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }.gsub("/", "::")
  end

  def constantize(camel_cased_word =nil)
    camel_cased_word ||= self
    names = camel_cased_word.split("::".freeze)

    # Trigger a built-in NameError exception including the ill-formed constant in the message.
    Object.const_get(camel_cased_word) if names.empty?

    # Remove the first blank element in case of '::ClassName' notation.
    names.shift if names.size > 1 && names.first.empty?

    names.inject(Object) do |constant, name|
      if constant == Object
        constant.const_get(name)
      else
        candidate = constant.const_get(name)
        next candidate if constant.const_defined?(name, false)
        next candidate unless Object.const_defined?(name)

        # Go down the ancestors to check if it is owned directly. The check
        # stops when we reach Object or the end of ancestors tree.
        constant = constant.ancestors.inject(constant) do |const, ancestor|
          break const    if ancestor == Object
          break ancestor if ancestor.const_defined?(name, false)
          const
        end

        # owner is in Object, so raise
        constant.const_get(name, false)
      end
    end
  end
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

  describe '#endpoint_for' do
    context 'with namespace' do
      subject { LocalIpDummyClass.new }
      it 'return namespace' do
        expect(subject.endpoint_for('test')).to eq(Endpoints::Test)
      end
    end

  end

  describe '#present' do

  end

end
