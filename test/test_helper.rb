require 'minitest/autorun'
require 'factory_bot'
require_relative 'factories/todos.rb'

def db_conf
	db_conf_file = File.join(File.expand_path('..', __dir__), 'db', 'config.yml')
	YAML.load(File.read(db_conf_file))
end

ActiveRecord::Base.establish_connection(db_conf['test'])

class Minitest::Test
  include FactoryBot::Syntax::Methods
end

