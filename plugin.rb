# plugins/ignore_password_length/plugin.rb
# name: ignore-password-length
# about: Plugin to ignore the minimum password length validation
# version: 0.1
# authors: Renato Rocha
# url: https://github.com/renatorocha1/ignore_password_length

enabled_site_setting :ignore_password_length_enabled

after_initialize do
  # Custom password validator that does nothing
  module ::IgnorePasswordLength
    class Engine < ::Rails::Engine
      engine_name "ignore_password_length"
      isolate_namespace IgnorePasswordLength
    end

    def self.skip_password_length_validation
      User.class_eval do
        validate :custom_password_validation

        def custom_password_validation
          # Skip password length validation
          return true
        end
      end
    end
  end

  # Hook into the Rails initialization process to apply our custom validator
  Rails.configuration.to_prepare do
    IgnorePasswordLength.skip_password_length_validation
  end
end
