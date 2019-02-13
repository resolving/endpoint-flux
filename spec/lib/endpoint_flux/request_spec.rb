require 'spec_helper'

RSpec.describe EndpointFlux::Request do
  it { should respond_to :headers }
  it { should respond_to :remote_ip }
  it { should respond_to :params }
  it { should respond_to :namespace }
  it { should respond_to :endpoint }
  it { should respond_to :scope }

  describe '#initialize' do
    context 'when all params specified' do
      let(:params) { { param: :val } }
      let(:headers) { { header: :val } }
      let(:remote_ip) { '127.0.0.1' }
      let(:namespace) { 'namespace' }

      it 'should set args' do
        request = EndpointFlux::Request.new(
          params: params,
          headers: headers,
          remote_ip: remote_ip,
          namespace: namespace
        )

        expect(request.params).to eq params
        expect(request.headers).to eq headers
        expect(request.remote_ip).to eq remote_ip
        expect(request.namespace).to eq namespace
      end

      context 'when params missed' do
        it 'should set default values' do
          request = EndpointFlux::Request.new

          expect(request.params).to be_empty
          expect(request.headers).to be_empty
          expect(request.remote_ip).to eq ''
          expect(request.namespace).to be_nil
        end
      end
    end
  end
end
