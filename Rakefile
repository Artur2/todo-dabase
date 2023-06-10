# typed: false

require 'rubocop/rake_task'
task default: %w[test]
task default: %w[lint test]

RuboCop::RakeTask.new(:lint) do |task|
    task.patterns = ['lib/**/*.rb', 'tests/**/*.rb']
    task.fail_on_error = false
end

task :main do
    ruby 'lib/main.rb'
end

task :test do
    ruby 'tests/todo_item_tests.rb'
    ruby 'tests/todo_manager_tests.rb'
end
