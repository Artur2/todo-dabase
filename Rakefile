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

task :tests do
  tests = Dir.glob('tests/*.rb').select { |e| File.file? e }
  puts tests
  tests.each do |e|
    ruby e
  end
end
