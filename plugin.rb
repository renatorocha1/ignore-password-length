# plugins/ignore_password_length/plugin.rb
# name: ignore-password-length
# about: Plugin to ignore the minimum password length validation
# version: 0.1
# authors: Renato Rocha
# url: https://github.com/renatorocha1/ignore_password_length

after_initialize do
    # Unregister the existing password length validation
    User.unregister_validator("password")

    # Register a custom password validator that does nothing
    User.register_validator("password") do
      # Skip password length validation
      true
    end
  end
