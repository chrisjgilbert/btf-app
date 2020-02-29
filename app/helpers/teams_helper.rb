module TeamsHelper
  def create_team_success_flash_message
    flash[:info] = "Strong picks! Are you sure about your Women's Downhill skier though? Remember you can change your picks right up until the deadline @ 10:30am Saturday 11th January."
  end

  def update_team_success_flash_message
    flash[:info] = "Nice, liking your transfer strategy. Your team has been updated."
  end

  def past_deadline_flash_message
    flash[:danger] = 'Cheeky. The deadline to update your team has passed!'
  end

  def team_already_created_flash_message
    flash[:danger] = 'Team already created'
  end

  def before_update_team_deadline?
    Time.now < deadline
  end

  def deadline
    # Saturday 11th January, 10:40
    Time.gm(2020,1,11,10,40,0)
  end
end
