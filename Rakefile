#!/usr/bin/env rake
require 'rspec/core/rake_task'
require "bundler/gem_tasks"

task :default => :spec

desc "Run specs"
task :spec do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = './spec/**/*_spec.rb'
  end
end

namespace :spec do
  task :clean do
    FileUtils.rm_rf(Dir.glob('spec/vcr/*'))
  end
end
