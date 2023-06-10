# typed: true

require 'minitest/autorun'
require 'sorbet-runtime'
require_relative '../lib/todo_manager'

module Todo
  class TodoManagerTests < Minitest::Test
    extend T::Sig
    sig { returns(TodoManager) }
    attr_accessor :manager

    def setup
      self.manager = Todo::TodoManager.new
    end

    def test_adding_item
      manager.add_item('test', 'test description')
      items = manager.get_all

      assert_equal 1, items.length

      item = manager.get_item_by_title('test')
      assert_equal item.title, 'test'
    end

    def test_deleting_item
      manager.add_item 'test', 'test description'
      manager.remove_item 'test'

      items = manager.get_all

      assert_equal 0, items.length
    end

    def test_updating_description
      manager.add_item('test', 'test description')

      manager.update_description('test', 'Test description')

      found_item = manager.get_item_by_title 'test'

      assert_equal found_item.description, 'Test description'
    end

    def test_due_date_add
      manager.add_item 'Test', 'test description'
      manager.add_or_update_due_date 'Test', Time.now

      found_item = manager.get_item_by_title 'Test'
      assert_equal found_item.overdue?, true
    end
  end
end
