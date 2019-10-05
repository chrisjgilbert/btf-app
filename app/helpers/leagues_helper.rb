module LeaguesHelper
  def league_already_created_flash_message
    flash[:danger] = 'You already have created a league!'
  end

  def league_successfully_created_flash_message
    flash[:success] = 'League successfully created!'
  end

  def unsuccessful_add_users_team_to_league_flash_message
    flash[:danger] = 'Woah, something went wrong there. Try again and if the same problem happens again please email us and tell us what you were doing.'
  end

end
