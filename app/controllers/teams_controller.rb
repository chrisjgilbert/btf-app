class TeamsController < ApplicationController
  before_action :user_has_already_created_a_team, only: [:new, :create]
  
  def new
    @team = Team.new
  end

  def create
    @team = current_user.build_team(team_params)
    if @team.save
      flash[:success] = 'Team created'
      redirect_to dashboard_path
    else
      render 'new'
    end
  end
  
  def show
    @team = Team.find(params[:id])
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def user_has_already_created_a_team
    if Team.where(user_id: current_user.id).exists?
      flash[:danger] = 'Team already created'
      redirect_to dashboard_path
    end
  end
end
