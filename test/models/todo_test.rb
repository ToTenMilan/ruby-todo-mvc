require_relative '../../app/models/todo'
require_relative '../test_helper'

describe Todo do
	before do
		@todo = FactoryBot.create(:wash_dishes)
	end

	describe 'todo attributes' do
		it 'should have its attributes' do
			@todo.title.must_equal 'wash dishes'
		end
	end

	after do
  	Todo.all.destroy_all
	end
end