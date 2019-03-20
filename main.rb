#!/usr/bin/env ruby
require 'highline'
require './app/controllers/todos_controller'
require './config/environments/development'
require './config/database_connection'
require './app/helpers/todos_helper'
require './lib/string'

class App < HighLine
  include TodosHelper

  def initialize
    @cli = HighLine.new
    @todos_controller = TodosController.new
    @params = nil
  end

  def start
    @cli.say "Welcome in ToDoApp - Here are your all todos:\n"

    loop do
      @cli.choose do |menu|
        menu.prompt = "\nSelect option to choose or task to toggle its completeness"

        menu.choice('[OPTION] Add new todo') { add_new_todo }
        menu.choice('[OPTION] show undone todos') { @params = { completed: false } }
        menu.choice('[OPTION] show done todos') { @params = { completed: true } }
        menu.choice('[OPTION] show all todos') { @params = nil }
        menu.choice('[OPTION] remove todo') { remove_todo_menu }

        @cli.say "\n"

        @todos_controller.index(@params).each do |todo|
          menu.choice(status_and_title(todo)) { toggle(todo) }
        end

        menu.choice(:Quit, "Exit program.") { exit }
      end
    rescue SystemExit, Interrupt
      @cli.say "Exiting..."
      exit
    end
  end

  private

  def add_new_todo
    title = @cli.ask("todo title: ")
    description = @cli.ask("todo description: ")
    @todos_controller.create(title: title, description: description)
    @cli.say "You have created ToDo titled: #{title}"
  end

  def remove_todo_menu
    todos = @todos_controller.index
    @cli.choose do |remove_menu|
      remove_menu.prompt = "\nSelect todo to remove"
      todos.each do |todo|
        remove_menu.choice("[REMOVE] #{todo.title}") do
          @todos_controller.destroy(id: todo.id)
          @cli.say('Todo removed')
        end
      end
      remove_menu.choice('Go back') { next }
    end
  end

  def toggle(todo)
    @todos_controller.update(id: todo.id, completed: !todo.completed)
    @cli.say ("#{todo.title} is now #{prettify(!todo.completed)}")
  end
end

App.new.start
