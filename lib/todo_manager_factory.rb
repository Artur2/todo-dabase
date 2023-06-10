# typed: strict

require 'singleton'
require_relative 'todo_manager'
require_relative 'database_todo_manager'
require 'sorbet-runtime'

module Todo
  # Factory for todo manager
  class TodoManagerFactory
    extend T::Sig
    include Singleton

    # Creating todo manager
    sig { returns(Todo::TodoManager) }
    def create
      DatabaseTodoManager.new
    end
  end
end
