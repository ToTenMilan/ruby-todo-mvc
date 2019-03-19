#!/usr/bin/env ruby
require 'highline'
require './app/controllers/todos_controller'
require './config/database_connection'
require './app/helpers/todos_helper'
require './lib/string'
include TodosHelper

class App
  def start
    cli = HighLine.new
    todos_controller = TodosController.new
    params = nil

    puts "Welcome in ToDoApp - Here are your all todos:\n"

    loop do
      cli.choose do |menu|
        menu.prompt = "\nSelect option to choose or task to toggle its completeness"

        menu.choice('[OPTION] Add new todo') do
          title = cli.ask("todo title: ")
          description = cli.ask("todo description: ")
          todos_controller.create(title: title, description: description)
          puts "You have created ToDo titled: #{title}"
        end

        menu.choice('[OPTION] show undone todos') do
          params = { completed: false }
        end

        menu.choice('[OPTION] show done todos') do
          params = { completed: true }
        end

        menu.choice('[OPTION] show all todos') do
          params = nil
        end

        menu.choice('[OPTION] remove todo') do
          todos = todos_controller.index
          cli.choose do |remove_menu|
            remove_menu.prompt = "\nSelect todo to remove"
            todos.each do |td|
              remove_menu.choice("[REMOVE] #{td.title}") do
                todos_controller.destroy(id: td.id); cli.say('Todo removed')
              end
            end

            remove_menu.choice('Go back') do
              next
            end
          end
        end

        todos = todos_controller.index(params)
        cli.say "\n"
        todos.each do |td|
          menu.choice("[#{humanize(td.completed)}] #{td.title}") do
            todos_controller.update(id: td.id, completed: !td.completed)
            puts ("#{td.title} is now #{humanize(!td.completed)}")
          end
        end

        menu.choice(:Quit, "Exit program.") { exit }
      end
    rescue SystemExit, Interrupt
      puts "Exiting..."
      exit
    end
  end
end

start

