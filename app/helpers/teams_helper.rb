module TeamsHelper
  def create_team_success_flash_message
    flash[:success] = "Great stuff! Your team has been created. Dont't forget you can come back and update your picks until midnight on 31st December 2019."
  end

  def update_team_success_flash_message
    flash[:success] = "Your team has been updated! Dont't forget you can come back and update your picks until midnight on 31st December 2019."
  end

  def before_update_team_deadline?
    Time.now < deadline
  end

  def deadline
    # Midnight on NYE
    Date.new(2019, 12, 31).midnight
  end
end
