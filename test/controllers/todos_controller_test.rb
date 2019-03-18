require './app/controllers/todos_controller'
require './test/test_helper'

class TodoTest < Minitest::Test
	describe TodosController do
		before do
			@todos_controller = TodosController.new
		end

		describe 'index' do
			it 'should show all tasks' do
				create(:todo)
				create(:wash_dishes)
				assert_equal [Todo.first, Todo.second], @todos_controller.index
			end

			it 'should show all completed tasks' do
				create(:todo)
				create(:wash_dishes)
				assert_equal [Todo.first], @todos_controller.index(completed: true)
			end
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

			it 'should return message if todo not found' do
				todo = create(:wash_dishes)
				message = 'Todo not found'
				assert_equal message, @todos_controller.destroy(id: todo.id - 1)
			end
		end

		describe 'update' do
			it 'should update only completness status of todo' do
				todo = create(:wash_dishes)
				@todos_controller.update(id: todo.id, completed: true)
				todo.reload
				assert_equal 'wash dishes', todo.title
				assert_equal true, todo.completed
			end

			it 'should return message if todo not found' do
				todo = create(:wash_dishes)
				message = 'Todo not found'
				assert_equal message, @todos_controller.update(id: todo.id - 1)
			end
		end

		after do
	  	Todo.all.destroy_all
		end
	end
end