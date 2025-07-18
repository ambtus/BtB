# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Make code changes take effect immediately without server restart.
  config.enable_reloading = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing.
  config.server_timing = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Append comments with runtime information tags to SQL queries in logs.
  config.active_record.query_log_tags_enabled = true

  # Annotate rendered view with file names.
  config.action_view.annotate_rendered_view_with_filenames = ENV['LOUD'].present?

  # Raise error when a before_action's only/except options reference missing actions.
  config.action_controller.raise_on_missing_callback_actions = true

  config.action_controller.allow_forgery_protection = false

  config.public_file_server.enabled = true

  # Log to STDOUT if asked
  if ENV['LOUD'].present?
    config.logger = ActiveSupport::Logger.new($stdout)
                                         .tap  { |l| l.formatter = Logger::Formatter.new }
                                         .then { |l| ActiveSupport::TaggedLogging.new(l) }
  end

  config.hosts << 'imac.local:3000'
  config.hosts << 'crunch.local:3000'
end
