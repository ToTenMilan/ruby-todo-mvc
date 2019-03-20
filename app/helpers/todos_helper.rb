module TodosHelper
  def prettify(bool)
    check = "\u2713".green
    cross = "\u274C".red
    bool ? check : cross
  end

  def status_and_title(todo)
    "[#{prettify(todo.completed)}] #{todo.title}"
  end
end
