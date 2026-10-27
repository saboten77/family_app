# frozen_string_literal: true

require "minitest/autorun"
require "uri"
require_relative "../../lib/database_safety/test_database_guard"

class TestDatabaseGuardTest < Minitest::Test
  Config = Struct.new(
    :name, :url, :adapter, :host, :database, :username, :configuration_hash,
    keyword_init: true
  )

  class Configurations
    attr_reader :arguments

    def initialize(configs)
      @configs = configs
    end

    def configs_for(**arguments)
      @arguments = arguments
      @configs
    end
  end

  class BrokenConfigurations
    def configs_for(**)
      raise URI::InvalidURIError, "postgresql://private-user:private-password@secret.example/secret_db"
    end
  end

  def setup
    @config = Config.new(
      name: "primary",
      url: DatabaseSafety::TestDatabaseGuard::EXPECTED_URL,
      adapter: "postgresql",
      host: "localhost",
      database: "family_app_test",
      username: "postgres",
      configuration_hash: { port: 5432, username: "postgres" }
    )
  end

  def test_accepts_the_expected_single_local_test_database
    configurations = Configurations.new([@config])

    assert DatabaseSafety::TestDatabaseGuard.verify!(configurations)
    assert_equal({ env_name: "test", include_hidden: true }, configurations.arguments)
  end

  def test_rejects_each_unexpected_connection_setting_with_its_condition_name
    invalid_configs = [
      [@config.dup.tap { |config| config.url = "postgresql://private-password@secret.example/secret_db" }, :url],
      [@config.dup.tap { |config| config.adapter = "mysql2" }, :adapter],
      [@config.dup.tap { |config| config.host = "secret.example" }, :host],
      [@config.dup.tap { |config| config.database = "secret_db" }, :database],
      [@config.dup.tap { |config| config.configuration_hash = { port: 5432, username: "private-user" } }, :username],
      [@config.dup.tap { |config| config.configuration_hash = { port: 5433, username: "postgres" } }, :port],
      [@config.dup.tap { |config| config.configuration_hash = { port: 5432, username: "postgres", password: "private-password" } }, :password],
      [@config.dup.tap { |config| config.configuration_hash = { port: 5432, username: "postgres", hostaddr: "192.0.2.1" } }, :hostaddr]
    ]

    invalid_configs.each do |config, condition|
      error = assert_raises(DatabaseSafety::TestDatabaseGuard::UnsafeConfigurationError) do
        DatabaseSafety::TestDatabaseGuard.verify!(Configurations.new([config]))
      end

      assert_equal condition.to_s, error.condition
      assert_equal DatabaseSafety::TestDatabaseGuard::FAILURE_MESSAGE, error.message
      refute_includes DatabaseSafety::TestDatabaseGuard.diagnostic_line(error), "private"
      refute_includes DatabaseSafety::TestDatabaseGuard.diagnostic_line(error), "secret"
    end
  end

  def test_rejects_missing_or_additional_database_configurations
    queue = @config.dup
    queue.name = "queue"

    [[], [@config, queue]].each do |configs|
      error = assert_raises(DatabaseSafety::TestDatabaseGuard::UnsafeConfigurationError) do
        DatabaseSafety::TestDatabaseGuard.verify!(Configurations.new(configs))
      end
      assert_equal "database_names", error.condition
    end
  end

  def test_rejects_libpq_service_and_host_address_overrides
    { "PGSERVICE" => :pgservice, "PGHOSTADDR" => :pghostaddr }.each do |key, condition|
      with_environment(key, "private-value") do
        error = assert_raises(DatabaseSafety::TestDatabaseGuard::UnsafeConfigurationError) do
          DatabaseSafety::TestDatabaseGuard.verify!(Configurations.new([@config]))
        end
        assert_equal condition.to_s, error.condition
        refute_includes DatabaseSafety::TestDatabaseGuard.diagnostic_line(error), "private-value"
      end
    end
  end

  def test_reports_only_condition_and_exception_class_for_configuration_errors
    error = assert_raises(DatabaseSafety::TestDatabaseGuard::UnsafeConfigurationError) do
      DatabaseSafety::TestDatabaseGuard.verify!(BrokenConfigurations.new)
    end

    assert_equal "configuration_resolution", error.condition
    assert_equal "URI::InvalidURIError", error.original_error_class
    diagnostic = DatabaseSafety::TestDatabaseGuard.diagnostic_line(error)
    assert_equal "[database-safety] condition=configuration_resolution error_class=URI::InvalidURIError", diagnostic
    refute_includes diagnostic, "private"
    refute_includes diagnostic, "secret"
    refute_includes error.message, "private"
    refute_includes error.message, "secret"
  end

  private

  def with_environment(key, value)
    original = ENV[key]
    ENV[key] = value
    yield
  ensure
    original.nil? ? ENV.delete(key) : ENV[key] = original
  end
end
