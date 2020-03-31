module Middlewares
  module Decorator
    module Paginate
      def self.perform(request, response, options)
        page, per_page = request.params.values_at(:page, :per_page)
        resources      = response.body[options[:wrapped_in]]

        if per_page != 'all' && resources
          resources = resources.page(page).per(per_page)

          response.body[options[:wrapped_in]] = resources
          response.body[:pagination] = { total_pages: resources.total_pages }
        end

        [request, response]
      end
    end
  end
end
