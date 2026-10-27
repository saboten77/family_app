# frozen_string_literal: true

# Replace ambient URLs before loading any Rails configuration. These values are
# deliberately invalid and are never used for a connection.
ENV["RAILS_ENV"] = "test"
ENV["DATABASE_URL"] = "postgresql://database-url.invalid/ignored"
ENV["PRIMARY_DATABASE_URL"] = "postgresql://primary-database-url.invalid/ignored"

begin
  require_relative "../config/application"
  require "active_record/database_configurations"

  app = Rails.application
  raw_configuration = app.config.database_configuration
  resolved_configuration = ActiveRecord::DatabaseConfigurations.new(raw_configuration)

  DatabaseSafety::TestDatabaseGuard.verify!(resolved_configuration)

  ordered_initializers = []
  app.initializers.tsort_each { |initializer| ordered_initializers << initializer.name.to_s }
  guard_index = ordered_initializers.index("database_safety.verify_test_database")
  active_record_index = ordered_initializers.index("active_record.initialize_database")

  unless guard_index && active_record_index && guard_index < active_record_index
    raise DatabaseSafety::TestDatabaseGuard::UnsafeConfigurationError.new(condition: :initializer_order)
  end

  puts "Test database configuration and initializer order are safe."
rescue DatabaseSafety::TestDatabaseGuard::UnsafeConfigurationError => error
  warn DatabaseSafety::TestDatabaseGuard.diagnostic_line(error)
  exit 1
rescue StandardError => error
  error_class = DatabaseSafety::TestDatabaseGuard.safe_error_class(error)
  warn "[database-safety] condition=configuration_check error_class=#{error_class}"
  exit 1
end
