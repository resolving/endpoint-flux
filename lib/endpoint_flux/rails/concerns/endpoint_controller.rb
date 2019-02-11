module EndpointFlux
  module Rails
    module Concerns
      module EndpointController
        extend ActiveSupport::Concern

        def present(namespace)
          _, response = endpoint_for(namespace).perform(request_object)

          headers.merge! response.headers
          render json: response.body
        end

        def endpoint_for(namespace)
          return namespace unless ::EndpointFlux.config.endpoints_namespace
          (::EndpointFlux.config.endpoints_namespace + '/' + namespace).camelize.constantize
        end

        def request_object
          ::EndpointFlux::Request.new(
            headers: headers.merge('Authorization' => request.headers['authorization']),
            remote_ip: remote_ip,
            params: endpoint_params
          )
        end

        def endpoint_params
          params.permit!.except(:controller, :action, :format).to_h.deep_symbolize_keys
        end

        def remote_ip
          ip = request.remote_ip.to_s

          if ip == '127.0.0.1'
            ip = request.env['HTTP_X_FORWARDED_FOR']
          end

          ip
        end
      end
    end
  end
end
