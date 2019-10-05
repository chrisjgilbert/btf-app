class LeaguesController < ApplicationController
  include LeaguesHelper
  before_action :user_has_already_created_a_league, only: [:create, :new]

  def index
    @leagues = League.all
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    @league.user = current_user
    if @league.save
      add_team_to_league(@league, current_user.team)
      league_successfully_created_flash_message
      redirect_to @league
    else
      render 'new'
    end
  end

  def show
    @league = League.find(params[:id])
  end

  private

  def league_params
    params.require(:league).permit(:name)
  end

  def add_team_to_league(league, team)
    league_membership = LeagueMembership.new(league_id: league.id, team_id: team.id)
    unless league_membership.save
      unsuccessful_add_users_team_to_league_flash_message
      render 'new'
    end
  end

  def user_has_already_created_a_league
    if League.where(user_id: current_user.id).exists?
      league_already_created_flash_message
      redirect_to dashboard_path
    end
  end
end
