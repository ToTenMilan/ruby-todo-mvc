require_relative '../models/todo'
require_relative 'application_controller'

class TodosController < ApplicationController
	def create(params)
		Todo.create(params)
	end
end
