class DashboardsController < ApplicationController
  include SessionsHelper
  include TeamsHelper

  def show 
    @current_user = current_user
  end
  
end
