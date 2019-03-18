#!/usr/bin/env ruby
require 'highline'
require './app/controllers/todos_controller'
require './config/database_connection'
require './app/helpers/todos_helper'
require './lib/string'
include TodosHelper



def start
	cli = HighLine.new
	todos_controller = TodosController.new
	# answer = cli.ask "What you think?"
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

			puts menu.singleton_methods(false)

			menu.choice('[OPTION] show all todos') do
				params = nil
			end

			menu.choice('[OPTION] remove todo') do
				menu.prompt = "\nSelect todo to remove"

				todos = todos_controller.index
				cli.choose do |remove_menu|
					todos.each do |td|
						remove_menu.choice("[REMOVE] #{td.title}") { todos_controller.destroy(id: td.id); cli.say('Todo removed') }
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
		# rescue SystemExit, Interrupt
	 #  	raise "Exiting..."
	 #  	exit
		end
	end
end

start


# # Default answer
# cli.ask("Company?  ") { |q| q.default = "none" }


# # Validation
# cli.ask("Age?  ", Integer) { |q| q.in = 0..105 }
# cli.ask("Name?  (last, first)  ") { |q| q.validate = /\A\w+, ?\w+\Z/ }


# # Type conversion for answers:
# cli.ask("Birthday?  ", Date)
# cli.ask("Interests?  (comma sep list)  ", lambda { |str| str.split(/,\s*/) })


# # Readin passwords:
# cli.ask("Enter your password:  ") { |q| q.echo = false }
# cli.ask("Enter your password:  ") { |q| q.echo = "x" }


# # ERb based output (with HighLine's ANSI color tools):
# cli.say("This should be <%= color('bold', BOLD) %>!")


# # Menus:
# cli.choose do |menu|
#   menu.prompt = "Please choose your favorite programming language?  "
#   menu.choice(:ruby) { cli.say("Good choice!") }
#   menu.choices(:python, :perl) { cli.say("Not from around here, are you?") }
#   menu.default = :ruby
# end

# ## Using colored indices on Menus
# HighLine::Menu.index_color   = :rgb_77bbff # set default index color

# cli.choose do |menu|
#   menu.index_color  = :rgb_999999      # override default color of index
#                                        # you can also use constants like :blue
#   menu.prompt = "Please choose your favorite programming language?  "
#   menu.choice(:ruby) { cli.say("Good choice!") }
#   menu.choices(:python, :perl) { cli.say("Not from around here, are you?") }
# end