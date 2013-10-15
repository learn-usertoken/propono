require 'singleton'

module Propono

  class ConfigurationError < Exception
  end

  class Configuration
    include Singleton

    SETTINGS = [:access_key, :secret_key, :queue_region, :queue_url]
    attr_writer *SETTINGS

    def initialize
    end

    SETTINGS.each do |setting|
      define_method setting do
        get_or_raise(setting)
      end
    end

    private

    def get_or_raise(setting)
      if val = instance_variable_get("@#{setting.to_s}")
        val
      else
        raise ConfigurationError.new("Configuration for #{setting} is not set")
      end
    end
  end
end
