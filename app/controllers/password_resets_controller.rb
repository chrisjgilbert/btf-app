class PasswordResetsController < ApplicationController
  include SessionsHelper
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: password_reset_params)

    if @user
      @user.create_password_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'Password reset email'
      render 'new'
    else
      flash[:danger] = 'Email address not found'
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "Can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.destroy_password_reset_digest
      flash[:info] = "Password has been updated"
      redirect_to team_path(@user.team)
    else
      render 'edit'
    end
  end

  private

  def valid_user
    @user = User.find_by(email: user_email_params)

    unless @user && @user.authenticated?(:password_reset, params[:id])
      redirect_to root_url 
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = 'Password reset has expired'
      redirect_to new_password_reset_path
    end
  end

  def password_reset_params
    params[:password_reset][:email].downcase
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_email_params
    params[:email]
  end
end
