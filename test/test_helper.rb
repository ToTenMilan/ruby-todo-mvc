require 'minitest/autorun'
require 'factory_bot'
require './config/environments/test'
require './test/factories/todos.rb'
require './config/database_connection'

class Minitest::Test
  include FactoryBot::Syntax::Methods
end
