module EndpointFlux
  module Rails
    module Concerns
      module EndpointController
        extend ActiveSupport::Concern

        def present(namespace)
          _, response = endpoint_for(namespace).perform(request_object)

          if response.redirected?
            redirect_to *response.redirect
          else
            headers.merge! response.headers
            render json: response.body
          end
        end

        def endpoint_for(namespace)
          return namespace unless ::EndpointFlux.config.endpoints_namespace
          (::EndpointFlux.config.endpoints_namespace + '/' + namespace).camelize.constantize
        end

        def request_object
          ::EndpointFlux::Request.new(
            headers: headers.merge('Authorization' => request.headers['authorization']),
            params: endpoint_params
          )
        end

        def endpoint_params
          params.permit!.except(:controller, :action, :format).to_h.deep_symbolize_keys
        end
      end
    end
  end
end
