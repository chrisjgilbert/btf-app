module LeagueMembershipsHelper
  def successful_league_membership_create_flash_msg(league_name)
    flash[:info] = "You have joined #{league_name}!"
  end

  def unsuccessful_league_membership_create_flash_msg
    flash[:danger] = 'Woah, something went wrong. We couldn"t add you to that league. Please notify us and we will look into it!'
  end

  def successful_league_membership_destroy_flash_msg(league_name)
    flash[:info] = "You have left #{league_name}!"
  end

  def unsuccessful_league_membership_destroy_flash_msg
    flash[:danger] = 'Woah, something went wrong. We couldn"t remove you from that league. Please notify us and we will look into it!'
  end
end
