module Middlewares
  require_relative 'middlewares/authenticator/skip'
  require_relative 'middlewares/authorizator/skip'
  require_relative 'middlewares/decorator/skip'
  require_relative 'middlewares/decorator/add_status'
  require_relative 'middlewares/policy/skip'
  require_relative 'middlewares/validator/empty'
end
