class LeaguesController < ApplicationController
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
      flash[:success] = 'League successfully created!'
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
    LeagueMembership.create(league_id: league.id, team_id: team.id)
  end
end
