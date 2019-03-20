require_relative '../models/todo'

class TodosController
  def index(params = nil)
    params ?
      Todo.where(completed: params[:completed]).order(title: 'ASC') :
      Todo.order(title: 'ASC')
  end

  def create(params)
    Todo.create!(params)
  end

  def update(params)
    find_todo(params)
    @todo&.update(completed: params[:completed]) || not_found
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
