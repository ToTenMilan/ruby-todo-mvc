require './app/models/todo'
require './config/database_connection'

Todo.create(title: 'Walk the dog', description: 'Through the fog')
Todo.create(title: 'Dog the walk', description: 'With the talk')
Todo.create(title: 'Go with the flow', description: 'By flowing the glow')