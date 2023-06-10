# typed: strict

require 'singleton'
require 'sqlite3'
require 'sorbet-runtime'

module Todo
  # Configuring database for runtime
  class DatabaseConfiguration
    extend T::Sig
    include Singleton

    DATABASE_NAME = 'todo.sqlite'

    # Configuring database, call at startup
    sig { void }
    def configure
      return unless database_file_exist? == false

      create_tables
    end

    # Check if db file exist
    sig { returns(T::Boolean) }
    def database_file_exist?
      File.exist? DATABASE_NAME
    end

    # Creating working tables
    sig { void }
    def create_tables
      db = SQLite3::Database.new DATABASE_NAME
      begin
        db.execute 'CREATE TABLE IF NOT EXISTS todo (title TEXT, description TEXT, status INT)'
      ensure
        db.close
      end
    end

    # Checking if tables exists
    sig { void }
    def check_table_exist
      db = SQLite3::Database.new DATABASE_NAME
      begin
        db.get_query_pragma 'pragma_table_list', 'todo' do |_row|
          return true
        end

        false
      ensure
        db.close
      end
    end
  end
end
