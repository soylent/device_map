require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

load 'ext/Rakefile'

desc 'Run tests and static code analyzer'
task ci: :prepare do
  Rake::Task['spec'].invoke
  Rake::Task['rubocop'].invoke
end

task default: :ci
