class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: user_email)
    if user && user.authenticate(user_password)
      log_in user
    else
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

  private

  def user_email
    params[:session][:email].downcase
  end

  def user_password
    params[:session][:password]
  end
end
