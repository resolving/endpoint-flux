Gem::Specification.new do |s|
  s.name          = 'endpoint-flux'
  s.version       = '0.0.0'
  s.date          = '2017-04-19'
  s.summary       = 'EndpointFlux!'
  s.description   = 'A simple way to organise API endpoints'
  s.authors       = ['Arturs Kreipans']
  s.files         = `git ls-files`.split($\)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
  s.homepage      = 'http://rubygems.org/gems/endpoint_flux'
  s.license       = 'MIT'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'byebug'
end
