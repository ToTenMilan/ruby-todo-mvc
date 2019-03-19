require_relative '../models/todo'

class TodosController
  def index(params = nil)
    if params
      Todo.where('completed = ?', params[:completed]).order(title: 'ASC')
    else
      Todo.order(title: 'ASC')
    end
  end

  def create(params)
    Todo.create!(params)
  end

  def update(params)
    find_todo(params)
    if @todo
      @todo.update(completed: params[:completed])
    else
      not_found
    end
  end

  def destroy(params)
    find_todo(params)
    @todo.try(:destroy) || not_found
  end

  private

  def find_todo(params)
    @todo = Todo.find_by(id: params[:id])
  end

  def not_found
    'Todo not found'
  end
end
