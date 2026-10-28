require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require_relative "../lib/database_safety/test_database_guard"

module FamilyApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.i18n.default_locale = :ja
    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.default_locale = :ja

    initializer "database_safety.verify_test_database", before: "active_record.initialize_database" do |app|
      if Rails.env.test?
        begin
          configurations = ActiveRecord::DatabaseConfigurations.new(app.config.database_configuration)
          DatabaseSafety::TestDatabaseGuard.verify!(configurations)
        rescue DatabaseSafety::TestDatabaseGuard::UnsafeConfigurationError => error
          warn DatabaseSafety::TestDatabaseGuard.diagnostic_line(error)
          raise
        rescue StandardError => error
          safe_error = DatabaseSafety::TestDatabaseGuard::UnsafeConfigurationError.new(
            condition: :initializer,
            original_error_class: DatabaseSafety::TestDatabaseGuard.safe_error_class(error)
          )
          warn DatabaseSafety::TestDatabaseGuard.diagnostic_line(safe_error)
          raise safe_error, cause: nil
        end
      end
    end
  end
end
