module Middlewares
  module Validator
    module Inline
      def self.perform(request, response, _options, &block)
        raise 'InlineValidator requires block with validations' unless block_given?

        validation = ::Dry::Validation.Schema(::Validations::Base, &block).call(request.params)
        unless validation.success?
          raise EndpointFlux::Exceptions::Validation, validation.messages
        end
        request.params = validation.output

        [request, response]
      end
    end
  end
end
