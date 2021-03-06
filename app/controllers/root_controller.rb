class RootController < ApplicationController
  include TeamsHelper
  def root
    if current_user
      if current_user.has_created_a_team?
        redirect_to team_path(current_user.team)
      else
        redirect_to welcome_path
      end
    else
      if before_update_team_deadline?
        redirect_to signup_path
      else
        redirect_to login_path
      end
    end
  end
end
