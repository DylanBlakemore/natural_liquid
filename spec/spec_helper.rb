require 'bundler/setup'
require 'pry'
require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
  minimum_coverage 100
  maximum_coverage_drop 0
end

require 'natural_liquid'

Bundler.setup

def suppress_log_output
  allow(STDOUT).to receive(:puts) # this disables puts
end

RSpec.configure do |config|
  config.before(:each) do
    suppress_log_output
  end
end
