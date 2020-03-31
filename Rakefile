task :init do
  require 'fileutils'
  puts 'Creating files...'
  FileUtils.cp_r 'lib/generators/endpoint_flux', 'app/endpoint_flux'
  FileUtils.cp 'lib/generators/initializers/endpoint_flux.rb', 'config/initializers/endpoint_flux.rb'
  puts 'Finished'
end
