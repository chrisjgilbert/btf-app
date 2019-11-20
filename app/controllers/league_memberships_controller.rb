class LeagueMembershipsController < ApplicationController
  include LeagueMembershipsHelper
  before_action :logged_in_user

  def create
    league_membership = LeagueMembership.new(league_membership_params)
    league = league_membership.league
    if league_membership.save
      # successful_league_membership_create_flash_msg(league.name)
      redirect_to league
    else
      unsuccessful_league_membership_create_flash_msg
      redirect_to dashboard_path
    end
  end

  def destroy
    league_membership = LeagueMembership.where(league_membership_params).first
    league = league_membership.league
    if league_membership.destroy
      # successful_league_membership_destroy_flash_msg(league.name)
      redirect_to league
    else
      unsuccessful_league_membership_destroy_flash_msg
      redirect_to dashboard_path
    end
  end

  private

  def league_membership_params
    { team_id: (params[:team_id]), league_id: params[:league_id] }
  end
end
