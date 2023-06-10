# typed: true

require_relative 'todo_manager_factory'
require_relative 'database_configuration'
require 'logcraft'

Logcraft.initialize
Todo::DatabaseConfiguration.instance.configure
todo_manager = Todo::TodoManagerFactory.instance.create

while true
  input = gets.chomp.to_s
  if input == 'q'
    break
  elsif input == 'a'
    puts 'enter title for todo'
    title = gets.chomp.to_s
    puts 'enter description for todo'
    description = gets.chomp.to_s
    todo_manager.add_item title, description
  elsif input == 'l'
    todo_manager.get_all.each do |todo|
      puts todo
      puts "Overdue: #{todo.overdue?}"
    end
  elsif input == 'd'
    title = gets.chomp.to_s
    todo_manager.remove_item title
  elsif input == 'u'
    puts 'Enter title of todo item'
    title = gets.chomp.to_s
    puts 'Enter description to update'
    description = gets.chomp.to_s

    todo_manager.update_description title, description
  else
    sleep 1000
  end
end
