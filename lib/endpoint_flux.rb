require 'endpoint_flux/class_loader'

require 'endpoint_flux/config'
require 'endpoint_flux/endpoint'
require 'endpoint_flux/exceptions'
require 'endpoint_flux/middlewares'

module EndpointFlux
  module_function

  def config(handler = nil)
    @config = handler if handler

    @config ||= EndpointFlux::Config.new
  end

  def clear
    @config = nil
  end
end
