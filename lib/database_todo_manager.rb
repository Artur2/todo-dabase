# typed: strict

require 'sqlite3'
require 'logcraft'
require_relative 'database_configuration'

module Todo
  # Representation of todo manager using sqlite database
  class DatabaseTodoManager < TodoManager
    extend T::Sig

    sig { void }
    def initialize
      self.logger = Logcraft.logger 'database_todo_manager'
    end

    # Adding item to todos
    sig { params(title: String, description: String).void }
    def add_item(title, description)
      db = SQLite3::Database.open DatabaseConfiguration::DATABASE_NAME
      begin
        db.execute 'INSERT INTO todo(title, description, status) VALUES (?, ?, ?)',
                   [title, description, Todo::PENDING]
      ensure
        db.close
      end
    end

    # Removing todo item from database
    sig { params(title: String).void }
    def remove_item(title)
      db = SQLite3::Database.open DatabaseConfiguration::DATABASE_NAME
      begin
        db.execute 'DELETE FROM todo WHERE title = ?', [title]
      ensure
        db.close
      end
    end

    # Getting todo item by title
    sig { params(title: String).returns(Todo::TodoItem) }
    def get_item_by_title(title)
      db = SQLite3::Database.open DatabaseConfiguration::DATABASE_NAME

      begin
        db.query 'SELECT * FROM todo WHERE title = ?', [title]
      ensure
        db.close
      end
    end

    # Returning all todo items
    sig { returns(T::Array[Todo::TodoItem]) }
    def get_all
      items = []
      db = SQLite3::Database.open DatabaseConfiguration::DATABASE_NAME
      begin
        db.query 'SELECT * FROM todo' do |result_set|
          result_set.each do |row|
            logger.info row
            item = TodoItem.new
            item.title = row[0]
            item.description = row[1]
            item.status = row[2]

            items.push(item)
          end
        end

        items
      ensure
        db.close
      end
    end

    # Updating description using database
    sig { params(title: String, description: String).void }
    def update_description(title, description)
      db = SQLite3::Database.open DatabaseConfiguration::DATABASE_NAME
      begin
        db.execute 'UPDATE todo SET description = ? WHERE title = ?', [description, title]
      ensure
        db.close
      end
    end

    protected

    sig { returns(T.untyped) }
    attr_accessor :logger
  end
end
