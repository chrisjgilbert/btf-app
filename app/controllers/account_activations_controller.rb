class AccountActivationsController < ApplicationController
  include AccountActivationsHelper
  def edit
    user = User.find_by(email: params[:email])
    puts "*"*1000
    p user
    p !user.activated?
    p user.authenticated?(:activation, params[:id])
    puts "*"*1000
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      account_activation_success_flash_msg
      redirect_to welcome_path
    else
      account_activation_failure_flash_msg
      redirect_to root_url
    end
  end
end
