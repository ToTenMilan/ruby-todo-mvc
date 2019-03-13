require 'minitest/autorun'
require_relative '../../app/models/todo'

def db_conf
	db_conf_file = File.join(File.expand_path('..', __dir__), '..', 'db', 'config.yml')
	YAML.load(File.read(db_conf_file))
end

ActiveRecord::Base.establish_connection(db_conf['test'])

describe Todo do
	before do
		@todo = Todo.create(title: 'first todo')
	end

	describe 'todo attributes' do
		it 'should have its attributes' do
			@todo.title.must_equal 'first todo'
		end
	end
end