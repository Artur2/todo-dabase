# typed: true

require 'sorbet-runtime'

module Todo
  # Todo item
  class TodoItem
    extend T::Sig
    attr_accessor :title, :description, :status

    sig { returns(T.nilable(Time)) }
    attr_accessor :due_date

    # Is todo item finished
    def finished?
      status == FINISHED
    end

    # Is todo item pending
    def pending?
      status == PENDING
    end

    sig { returns(T::Boolean) }
    def overdue?
      return false if due_date.nil?

      due_date < Time.now
    end

    # Overrides default behaviour
    def to_s
      "Title: #{title}, Description: #{description}, Status: #{status}"
    end
  end
end
