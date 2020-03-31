require 'endpoint_flux'

EndpointFlux.config.middlewares_namespaces << 'middlewares'

EndpointFlux.config.default_middlewares :authenticator, :skip
EndpointFlux.config.default_middlewares :authorizator, :skip
EndpointFlux.config.default_middlewares :validator, :empty
EndpointFlux.config.default_middlewares :policy,    :skip
EndpointFlux.config.default_middlewares :decorator, :skip


EndpointFlux::Endpoint.class_eval do
  define_method(:raise_validation_error) do |errors|
    raise EndpointFlux::Exceptions::Validation, errors
  end
end

rescue_from_exceptions = [
    EndpointFlux::Exceptions::Validation,
    EndpointFlux::Exceptions::Forbidden,
    EndpointFlux::Exceptions::Unauthorized,
    EndpointFlux::Exceptions::NotFound,
    EndpointFlux::Exceptions::ServiceUnavailable
]

EndpointFlux.config.rescue_from(rescue_from_exceptions) do |_, attrs, exception|
  attrs[1].body.merge!(exception.to_hash)
  attrs
end

EndpointFlux::Request.class_eval do
  attr_accessor :current_user_params

  define_method(:current_user) do
    @current_user ||= begin
      if current_user_params && current_user_params['id']
        User.find_by(id: current_user_params['id'])
      end
    end
  end
end
