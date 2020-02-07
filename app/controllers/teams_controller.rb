class TeamsController < ApplicationController
  include TeamsHelper
  include LeaguesHelper
  before_action :logged_in_user
  before_action :activated_user
  before_action :user_has_already_created_a_team, only: [:new, :create]
  before_action :set_team,                        only: [:show, :edit, :update]
  before_action :load_all_competitions,           only: [:new, :create, :edit, :update]
  before_action :load_all_competitors,            only: [:new, :create, :edit, :update]
  skip_before_action :verify_authenticity_token,  only: [:team_selection]
  
  def new
    @team = Team.new
    @picks = @competitions.count.times { @team.picks.build }
  end

  def create
    @team = current_user.build_team(team_params)
    if @team.save
      @team.join_main_btf_league # turn this into an after create action
      create_team_success_flash_message
      redirect_to @team
    else
      if team_params[:captain_id].present?
        @current_captain = Competitor.find(team_params[:captain_id])
      end
      render 'new'
    end
  end
  
  def show
    return redirect_to welcome_path unless current_user.has_created_a_team?
  end
  
  def edit
    @picks = @team.picks
    @captain_options = @picks.map { |pick| pick.competitor }
    @current_captain = @team.captain
  end

  def update
    if @team.update(team_params)
      update_team_success_flash_message
      redirect_to @team
    else 
      @current_captain = @team.captain
      render 'edit'
    end
  end

  def team_selection
    current_selection            = team_selection_params[:currentSelection].map(&:to_i)
    @current_transfer_selections = current_selection - current_team_picks
    replaced_picks               = current_team_picks - current_selection

    @current_captain_selection    = Competitor.find(team_selection_params[:currentCaptainId])
    @current_team_captain         = current_team_captain
    @captain_transfer_value = @current_team_captain == @current_captain_selection ? 0 : 1

    @transfers_count        = current_user_team.transfers_made + @current_transfer_selections.length + @captain_transfer_value

    @active_transfer_count = @transfers_count - current_user_team.transfers_made

    @current_transfer_selections = Competitor.find(@current_transfer_selections)
    @replaced_picks              = Competitor.find(replaced_picks)

    current_selection = Competitor.find(current_selection)
    @captain_options  = current_selection.reject(&:is_favourite?)
    @favourite_count  = current_selection.length - @captain_options.length

    respond_to do |format|
      format.js { render action: :team_selection }
    end
  end

  private

  def current_user_team
    current_user.team
  end

  def current_team_picks
    current_user_team.picks.map(&:competitor).map(&:id)
  end

  def current_team_captain
    current_user_team.captain
  end

  def team_params
    params.require(:team).permit(:name, :captain_id, :transfers_made, picks_attributes: [:id, :competitor_id])
  end

  def team_selection_params
    params.require(:data)
  end

  def user_has_already_created_a_team
    if Team.where(user_id: current_user.id).exists?
      team_already_created_flash_message
      redirect_to team_path(current_user.team)
    end
  end

  def before_update_team_deadline
    unless before_update_team_deadline?
      past_deadline_flash_message
      redirect_to team_path(current_user.team)
    end
  end

  def set_team
    @team = Team.find(params[:id])
  end

  def load_all_competitions
    @competitions ||= Competition.all
  end

  def load_all_competitors
    @competitors ||= Competitor.all
  end
end
