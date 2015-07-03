# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:rubocop) do |task|
  task.options.push('--fail-level', 'convention')
end

load 'ext/Rakefile'

desc 'Run tests and static code analyzer'
task ci: :prepare do
  Rake::Task['spec'].invoke
  Rake::Task['rubocop'].invoke
end

task default: :ci
