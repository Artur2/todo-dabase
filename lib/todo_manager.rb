# typed: strict

require 'sorbet-runtime'
require_relative 'todo_item'
require_relative 'statuses'

module Todo
  # Todo manager
  class TodoManager
    extend T::Sig
    sig { void }
    def initialize
      self.items = []
    end

    # Adding item to todos
    sig { params(title: String, description: String).void }
    def add_item(title, description)
      item = Todo::TodoItem.new
      item.title = title
      item.description = description
      item.status = PENDING

      items.push item
    end

    # Removing todo item by title
    sig { params(title: String).void }
    def remove_item(title)
      self.items = items.select { |i| i.title != title }
    end

    # Returns todo item by title
    sig { params(title: String).returns(Todo::TodoItem) }
    def get_item_by_title(title)
      items.find { |e| e.title == title }
    end

    # Getting all todos
    sig { returns(T::Array[Todo::TodoItem]) }
    def get_all
      items
    end

    # Updating description of todo
    sig { params(title: String, description: String).void }
    def update_description(title, description)
      found_item = items.find { |e| e.title == title }
      return if found_item.nil?

      found_item.description = description
    end

    sig { params(title: String, due_time: Time).void }
    def add_or_update_due_date(title, due_time)
      todo_item = get_item_by_title title
      return unless todo_item != nil?

      todo_item.due_date = due_time
    end

    protected

    sig { returns(T::Array[Todo::TodoItem]) }
    attr_accessor :items
  end
end
