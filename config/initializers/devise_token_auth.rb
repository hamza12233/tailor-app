DeviseTokenAuth.setup do |config|
  config.token_cost = Rails.env.development? ? 4 : 10
  config.change_headers_on_each_request = false
  config.max_number_of_devices = 3
  config.check_current_password_before_update = :password
  config.default_callbacks = false
  config.default_confirm_success_url = "#{Rails.application.secrets.domain_frontend}/login"
  config.default_password_reset_url = "#{Rails.application.secrets.domain_frontend}/reset-password"
end
