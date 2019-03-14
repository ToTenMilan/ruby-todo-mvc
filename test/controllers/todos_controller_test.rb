require_relative '../../app/controllers/todos_controller'
require_relative '../test_helper'

class TodoTest < Minitest::Test
	describe TodosController do
		before do
			@todos_controller = TodosController.new
		end

		describe 'create' do
			it 'should create todo' do
				@todos_controller.create(title: 'foo', description: 'bar')
				assert_equal 'foo', Todo.first.title
			end

			it 'should not create todo for not unique title' do
				@todos_controller.create(title: 'wash dishes')
				assert_raises ActiveRecord::RecordInvalid do
					@todos_controller.create(title: 'wash dishes')
				end
			end

			it 'should not create todo for wrong params' do
				assert_raises ActiveModel::UnknownAttributeError do
					@todos_controller.create(foo: 'bar')
				end
			end
		end

		describe 'destroy' do
			it 'should destroy todo' do
				todo = create(:wash_dishes)
				assert_equal 1, Todo.count
				@todos_controller.destroy(id: todo.id)
				assert_equal 0, Todo.count
			end

			it 'should raise error if todo not found' do
				todo = create(:wash_dishes)
				assert_raises ActiveRecord::RecordNotFound do
					@todos_controller.destroy(id: todo.id - 1)
				end
			end
		end

		after do
	  	Todo.all.destroy_all
		end
	end
end