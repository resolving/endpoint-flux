require_relative '../../middlewares/shared_examples'

RSpec.describe EndpointFlux::Middlewares::Authorizator::Skip do
  include_examples 'perform does not change the params'
end
