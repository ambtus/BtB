# frozen_string_literal: true

require 'simplecov'

require 'cucumber/rails'
DatabaseCleaner.strategy = :transaction
Capybara.match = :prefer_exact
