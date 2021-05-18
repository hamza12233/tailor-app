class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: User::ATTRIBUTES_WHITELIST)
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?
end
