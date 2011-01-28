# This is based on the official RSpec tm-bundle
require 'rubygems'

ENV['TM_PROJECT_DIRECTORY'] ||= File.dirname(ENV['TM_FILEPATH'])

def gemfile?
  File.exist?(File.join(ENV['TM_PROJECT_DIRECTORY'], 'Gemfile'))
end

if gemfile?
  require "bundler"
  Bundler.setup
else
  candidate_rspec_lib_paths = Dir.glob(File.join(ENV['TM_PROJECT_DIRECTORY'],'vendor','{plugins,gems}','{rspec,rspec-core}{,-[0-9]*}', 'lib'))
  candidate_rspec_lib_paths << File.join(ENV['TM_RSPEC_HOME'], 'lib') if ENV['TM_RSPEC_HOME']
  rspec_lib = candidate_rspec_lib_paths.detect { |dir| File.exist?(dir) }

  $LOAD_PATH.unshift(rspec_lib) if rspec_lib
end

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..')))
require "cucumber/mate/feature_helper"
require "cucumber/mate/runner"