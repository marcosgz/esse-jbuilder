# frozen_string_literal: true

require "bundler/setup"
require "pry"
require "esse/rspec"
require "esse/jbuilder"

require_relative "support/hooks/rails"

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.include Hooks::Rails
end
