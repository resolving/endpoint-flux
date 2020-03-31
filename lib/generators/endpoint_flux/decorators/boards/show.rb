module Decorators
  module Boards
    class Show < Representable::Decorator
      include Representable::JSON

      property :id
      property :name
      property :link
      collection :articles do
        property :id
        property :name
        property :board_id
        collection :tasks do
          property :id
          property :title
          property :article_id
        end
      end

    end
  end
end
