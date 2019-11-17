class LeaguesController < ApplicationController
  include LeaguesHelper
  before_action :logged_in_user
  # before_action :user_has_already_created_a_league, only: [:create, :new]

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
      @league.join(@current_user.team.id)
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

  # def user_has_already_created_a_league
  #   if League.where(user_id: current_user.id).exists?
  #     league_already_created_flash_message
  #     redirect_to dashboard_path
  #   end
  # end
end
