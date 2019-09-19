class TeamsController < ApplicationController
  include TeamsHelper
  before_action :user_has_already_created_a_team, only: [:new, :create]
  
  def new
    @team = Team.new
    @competitions = Competition.all
    @picks = @team.picks.build
  end

  def create
    @team = current_user.build_team(team_params)
    if @team.save
      create_team_success_flash_message
      redirect_to dashboard_path
    else
      render 'new'
    end
  end
  
  def show
    @team = Team.find(params[:id])
  end
  
  def edit
    @team = Team.find(params[:id])
    @picks = @team.picks
  end

  def update
    @team = Team.find(params[:id])
    @team.update(team_params)
    update_team_success_flash_message
    redirect_to @team
  end

  private

  def team_params
    params.require(:team).permit(:name, picks_attributes: [:id, :competitor_id])
  end

  def user_has_already_created_a_team
    if Team.where(user_id: current_user.id).exists?
      flash[:danger] = 'Team already created'
      redirect_to dashboard_path
    end
  end
end
