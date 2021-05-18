# frozen_string_literal: true
class Api::V1::Auth::ConfirmationsController < DeviseTokenAuth::ConfirmationsController

  def show
    super do |user|
      sign_in(user)
    end
  rescue ActionController::RoutingError
    redirect_to DeviseTokenAuth::Url.generate(redirect_url, account_confirmation_success: false)
  end

  private

  def redirect_url
    params[:redirect_url].presence || DeviseTokenAuth.default_confirm_success_url
  end
end
