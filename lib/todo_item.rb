# typed: true

module Todo
    # Todo item
    class TodoItem
        attr_accessor :title, :description, :status

        # Is todo item finished
        def finished?
            status == FINISHED
        end

        # Is todo item pending
        def pending?
            status == PENDING
        end

        def to_s
            "Title: #{title}, Description: #{description}, Status: #{status}"
        end
    end
end
