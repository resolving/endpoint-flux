module Decorators
  module Articles
    class Base < Representable::Decorator
      include Representable::JSON

      property :id
      property :name
      property :board_id

    end
  end
end
