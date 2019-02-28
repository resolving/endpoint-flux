require 'spec_helper'

RSpec.describe EndpointFlux::Response do
  subject { EndpointFlux::Response.new(params) }
  let(:empty_subject) { EndpointFlux::Response.new() }
  
  describe '#success?' do
    context 'when valid params given' do
      Array(200..209).each do |status|
        let(:params) { { headers: {}, body: {status: status}  } }
        it "returns true for status #{status}" do
          expect(subject.success?).to be_truthy
        end
      end
    end

    context 'when wrong params given' do
      let(:status) { 400 }
      let(:params) { { headers: {}, body: {status: status}  } }
      it 'returns false for not a success status' do
        expect(subject.success?).to be_falsey
      end
      
      describe 'when Response initialized without params' do
        it 'returns false for not a success status' do
          expect(empty_subject.success?).to be_falsey
        end
      end
    end
  end

  describe '#invalid?' do
    let(:params) { { headers: {}, body: {status: status}  } }
    context 'when valid params given' do
      let(:status) { 422 }
      
      it 'returns true for status 422' do
        expect(subject.invalid?).to be_truthy
      end
    end
  
    context 'when wrong params given' do
      let(:status) { 400 }
      
      it 'returns false for not an invalid status' do
        expect(subject.invalid?).to be_falsey
      end
    
      describe 'when Response initialized without params' do
        it 'returns false for not an invalid status' do
          expect(empty_subject.invalid?).to be_falsey
        end
      end
    end
  end

  describe '#forbidden?' do
    let(:params) { { headers: {}, body: {status: status}  } }
    context 'when valid params given' do
      let(:status) { 403 }
    
      it 'returns true for status 403' do
        expect(subject.forbidden?).to be_truthy
      end
    end
  
    context 'when wrong params given' do
      let(:status) { 400 }
    
      it 'returns false for not a forbidden status' do
        expect(subject.forbidden?).to be_falsey
      end
    
      describe 'when Response initialized without params' do
        it 'returns false for not a forbidden status' do
          expect(empty_subject.forbidden?).to be_falsey
        end
      end
    end
  end

  describe '#unauthorized?' do
    let(:params) { { headers: {}, body: {status: status}  } }
    context 'when valid params given' do
      let(:status) { 401 }
    
      it 'returns true for status 401' do
        expect(subject.unauthorized?).to be_truthy
      end
    end
  
    context 'when wrong params given' do
      let(:status) { 400 }
    
      it 'returns false for not a unauthorized status' do
        expect(subject.unauthorized?).to be_falsey
      end
    
      describe 'when Response initialized without params' do
        it 'returns false for not a unauthorized status' do
          expect(empty_subject.unauthorized?).to be_falsey
        end
      end
    end
  end

  describe '#unauthorized?' do
    let(:params) { { headers: {}, body: {status: status}  } }
    context 'when valid params given' do
      let(:status) { 404 }
    
      it 'returns true for status 404' do
        expect(subject.not_found?).to be_truthy
      end
    end
  
    context 'when wrong params given' do
      let(:status) { 400 }
    
      it 'returns false for not a not_found status' do
        expect(subject.not_found?).to be_falsey
      end
    
      describe 'when Response initialized without params' do
        it 'returns false for not a not_found status' do
          expect(empty_subject.not_found?).to be_falsey
        end
      end
    end
  end
end
