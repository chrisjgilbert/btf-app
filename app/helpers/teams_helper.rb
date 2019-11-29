module TeamsHelper
  def create_team_success_flash_message
    flash[:info] = "Strong picks...are you sure about your women's downhill skier though?? Remember you can change change your picks right up until the deadline @ 6pm Saturday 4th January"
  end

  def update_team_success_flash_message
    flash[:info] = "Your team has been updated! Dont't forget you can come back and update your picks until midnight on 31st December 2019."
  end

  def past_deadline_flash_message
    flash[:danger] = 'Cheeky. The deadline has passed to update your team.'
  end

  def team_already_created_flash_message
    flash[:danger] = 'Team already created'
  end

  def before_update_team_deadline?
    Time.now < deadline
  end

  def deadline
    # Midnight on NYE
    Date.new(2019, 12, 31).midnight
  end
end
