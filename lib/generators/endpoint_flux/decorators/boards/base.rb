module Decorators
  module Boards
    class Base < Representable::Decorator
      include Representable::JSON

      property :id
      property :name
      property :link

    end
  end
end
