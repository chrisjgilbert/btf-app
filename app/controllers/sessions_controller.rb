class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: user_email)
    if user && user.authenticate(user_password)
      if user.activated?
        log_in user
        redirect_back_or dashboard_path
      else
        flash[:warning] = 'Account not activated yet. Check your email for the activation link.'
        redirect_to root_url
      end
    else
      flash[:danger] = 'Invalid email/password combination'
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
