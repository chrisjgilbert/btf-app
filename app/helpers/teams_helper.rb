module TeamsHelper
  def create_team_success_flash_message
    flash[:info] = "Strong picks! Are you sure about your Women's Downhill skier though? Remember you can change your picks right up until the deadline @ 6pm Saturday 4th January."
  end

  def update_team_success_flash_message
    flash[:info] = "Your team has been updated! Dont't forget you can come back and update your picks until the deadline @ 6pm Saturday 4th January."
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
    # 6pm on 4th January
    Time.gm(2020,1,6,16,0,0)
  end
end
