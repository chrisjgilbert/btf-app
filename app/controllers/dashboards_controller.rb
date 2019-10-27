class DashboardsController < ApplicationController
  include SessionsHelper
  include TeamsHelper

  before_action :logged_in_user
  before_action :activated_user

  def show 
    @current_user = current_user
  end
  
end
