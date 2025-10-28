# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'

# Load additional helpers, support files, and custom matchers
Rails.root.glob('spec/support/**/*.rb').sort.each { |f| require f }

# Maintain test schema
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # Paths for fixtures (if you still use any)
  config.fixture_paths = [Rails.root.join('spec/fixtures')]

  # Use transactional fixtures by default
  config.use_transactional_fixtures = true

  # Include FactoryBot syntax methods (`create`, `build`, etc.)
  config.include FactoryBot::Syntax::Methods

  # Auto infer spec type (model, controller, request, etc.) by file location
  config.infer_spec_type_from_file_location!

  # Filter noise from Rails logs in test output
  config.filter_rails_from_backtrace!

  # DatabaseCleaner setup
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

# Shoulda Matchers config (for validations and associations)
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
