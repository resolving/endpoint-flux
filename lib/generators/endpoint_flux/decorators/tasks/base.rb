module Decorators
  module Tasks
    class Base < Representable::Decorator
      include Representable::JSON

      property :id
      property :title
      property :article_id

    end
  end
end
