require 'spec_helper'

RSpec.describe EndpointFlux::Config do
  it 'sets flow' do
    subject.flow %i[hey bey]
    expect(subject.flow).to eq(%i[hey bey])
  end
end
