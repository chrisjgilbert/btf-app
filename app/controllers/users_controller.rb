class UsersController < ApplicationController
  include UsersHelper
  include TeamsHelper

  def new
    unless before_update_team_deadline?
      flash[:info] = 'Sorry, the signup deadline has now passed'
      return redirect_to login_path
    else
      @user = User.new
    end
  end

  def create
    return redirect_to login_path unless before_update_team_deadline?

    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      account_activation_email_send_flash_message(@user)
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
