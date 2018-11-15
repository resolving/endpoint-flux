require_relative 'lib/endpoint_flux/version' # frozen_string_literal: true

Gem::Specification.new do |s|
  s.name          = 'endpoint-flux'
  s.version       = EndpointFlux::VERSION
  s.summary       = 'EndpointFlux!'
  s.description   = 'A simple way to organise API endpoints'
  s.authors       = ['Arturs Kreipans']
  s.files         = `git ls-files`.split($\)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
  s.homepage      = 'http://rubygems.org/gems/endpoint-flux'
  s.license       = 'MIT'

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'rspec'
end
