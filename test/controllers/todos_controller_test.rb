require_relative '../../app/controllers/todos_controller'
require_relative '../test_helper'

describe Todo do
	before do
		@todos_controller = TodosController.new
	end

	describe 'todo attributes' do
		it 'should create todo' do
			@todos_controller.create(title: 'foo', description: 'bar')
			assert_equal 'foo', Todo.first.title
		end
	end

	after do
  	Todo.all.destroy_all
	end
end