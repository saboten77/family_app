# frozen_string_literal: true

module DatabaseSafety
  class TestDatabaseGuard
    EXPECTED_URL = "postgresql://postgres@localhost:5432/family_app_test"
    EXPECTED_DATABASES = [ "primary" ].freeze
    FAILURE_MESSAGE = "Test database safety check failed; database configuration values were not displayed."

    class UnsafeConfigurationError < StandardError
      attr_reader :condition, :original_error_class

      def initialize(condition:, original_error_class: nil)
        @condition = condition.to_s
        @original_error_class = original_error_class
        super(FAILURE_MESSAGE)
      end
    end

    def self.verify!(database_configurations)
      configurations = database_configurations.configs_for(
        env_name: "test",
        include_hidden: true
      )

      reject!(:database_names, configurations.map(&:name).sort == EXPECTED_DATABASES)

      configurations.each do |config|
        reject!(:url, config.url == EXPECTED_URL)
        reject!(:adapter, config.adapter == "postgresql")
        reject!(:host, config.host == "localhost")
        reject!(:database, config.database == "family_app_test")
        reject!(:username, config_value(config, :username) == "postgres")
        reject!(:port, config_value(config, :port).to_i == 5432)
        reject!(:password, blank?(config_value(config, :password)))
        reject!(:hostaddr, blank?(config_value(config, :hostaddr)))
      end

      # These libpq variables can supply an alternate network target.
      reject!(:pgservice, blank?(ENV["PGSERVICE"]))
      reject!(:pghostaddr, blank?(ENV["PGHOSTADDR"]))

      true
    rescue UnsafeConfigurationError
      raise
    rescue StandardError => error
      raise UnsafeConfigurationError.new(
        condition: :configuration_resolution,
        original_error_class: safe_error_class(error)
      ), cause: nil
    end

    def self.diagnostic_line(error)
      error_class = error.original_error_class || safe_error_class(error)
      "[database-safety] condition=#{error.condition} error_class=#{error_class}"
    end

    def self.safe_error_class(error)
      error.class.name.to_s.gsub(/[^A-Za-z0-9_:]/, "")
    end

    def self.config_value(config, key)
      hash = config.configuration_hash
      hash[key] || hash[key.to_s]
    end
    private_class_method :config_value

    def self.blank?(value)
      value.nil? || value.to_s.empty?
    end
    private_class_method :blank?

    def self.reject!(condition, passed)
      raise UnsafeConfigurationError.new(condition: condition) unless passed
    end
    private_class_method :reject!
  end
end
