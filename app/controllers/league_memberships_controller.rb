class LeagueMembershipsController < ApplicationController
  def create
    league_membership = LeagueMembership.new(league_membership_params)
    if league_membership.save
      redirect_to league_membership.league
    end
  end

  def destroy
    league_membership = LeagueMembership.where(league_membership_params).first
    league_membership.destroy
    redirect_to league_membership.league
  end

  private

  def league_membership_params
    { team_id: (params[:team_id]), league_id: params[:league_id] }
  end
end
