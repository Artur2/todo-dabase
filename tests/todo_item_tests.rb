# typed: true
require_relative '../lib/todo_item'
require_relative '../lib/statuses'
require 'minitest/autorun'

module Todo
    # Tests for todo item
    class TodoItemTests < Minitest::Test
        def setup; end

        def test_valid_attributes
            todo_item = Todo::TodoItem.new
            todo_item.title = 'test title'
            todo_item.description = 'test description'
            todo_item.status = FINISHED

            assert_equal todo_item.title, 'test title'
            assert_equal todo_item.description, 'test description'
            assert_equal todo_item.status, FINISHED
        end
    end
end
