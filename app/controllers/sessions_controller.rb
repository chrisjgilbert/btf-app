class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: user_email)
    if user && user.authenticate(user_password)
      if user.activated?
        log_in user
        redirect_back_or redirect_from_login_path(user)
      else
        flash[:warning] = 'Account not activated yet. Check your email for the activation link.'
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
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

  def redirect_from_login_path(user)
    if user.has_created_a_team?
      team_path(user.team)
    else
      welcome_path
    end
  end
end
