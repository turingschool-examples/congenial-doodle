# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  enable_coverage :branch
end
require 'pry'
require 'rspec'

require_relative '../lib/carnival'
require_relative '../lib/ride'
require_relative '../lib/visitor'

RSpec.configure do |config|
  config.disable_monkey_patching!
end
