class TeamsController < ApplicationController
  include TeamsHelper
  before_action :user_has_already_created_a_team, only: [:new, :create]
  before_action :before_update_team_deadline,     only: [:edit, :update]
  before_action :set_team,                        only: [:show, :edit, :update]
  before_action :load_all_competitions,           only: [:new, :create, :edit, :update]
  before_action :load_all_competitors,            only: [:new, :create, :edit, :update]
  
  def new
    @team = Team.new
    @picks = @competitions.count.times { @team.picks.build }
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
  end
  
  def edit
    @picks = @team.picks
  end

  def update
    if @team.update(team_params)
      update_team_success_flash_message
      redirect_to @team
    else 
      render 'edit'
    end
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

  def before_update_team_deadline
    unless before_update_team_deadline?
      flash[:danger] = 'Cheeky. The deadline has passed to update your team.'
      redirect_to dashboard_path
    end
  end

  def set_team
    @team = Team.find(params[:id])
  end

  def load_all_competitions
    @competitions = Competition.all
  end

  def load_all_competitors
    @competitors = Competitor.all
  end
end
