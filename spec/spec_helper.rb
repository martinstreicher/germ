# frozen_string_literal: true

require 'debug'
require 'factory_bot'
require 'faker'
require 'germ'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.disable_monkey_patching!
  config.example_status_persistence_file_path = '.rspec_status'
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.definition_file_paths = [File.join(File.dirname(__FILE__), 'factories')]
FactoryBot.find_definitions
