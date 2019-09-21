class DashboardsController < ApplicationController
  include SessionsHelper
  include TeamsHelper

  before_action :logged_in_user

  def show 
    @current_user = current_user
  end
  
end
