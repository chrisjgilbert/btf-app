class SessionsController < ApplicationController
  before_action :redirect_to_dashboard_if_logged_in, except: [:destroy]
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: user_email)
    if user && user.authenticate(user_password)
      log_in user
      redirect_to dashboard_path
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

  def redirect_to_dashboard_if_logged_in
    if logged_in?
      redirect_to dashboard_path
    end
  end
end
