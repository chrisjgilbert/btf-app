class LeaguesController < ApplicationController
  include LeaguesHelper
  before_action :logged_in_user
  before_action :user_has_created_a_team

  def index
    @btf_leagues = [League.first]
    @my_leagues = current_user.team.leagues_a_member_of&.sort_by(&:name)
    @other_leagues = current_user.team.leagues_not_a_member_of&.sort_by(&:name)
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    @league.user = current_user
    if @league.save
      @league.join(current_user.team.id)
      league_successfully_created_flash_message
      redirect_to @league
    else
      render 'new'
    end
  end

  def show
    @league = League.find(params[:id])
  end

  def stage_3
  end

  private

  def league_params
    params.require(:league).permit(:name)
  end

  def user_has_created_a_team
    unless Team.where(user_id: current_user.id).exists?
      flash[:info] = 'Please create a team first.'
      redirect_to new_team_path
    end
  end
end
