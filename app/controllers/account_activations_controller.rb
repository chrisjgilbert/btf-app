class AccountActivationsController < ApplicationController
  include AccountActivationsHelper
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      account_activation_success_flash_msg
      redirect_to new_team_path
    else
      account_activation_failure_flash_msg
      redirect_to root_url
    end
  end
end
