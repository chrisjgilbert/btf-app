class TeamsController < ApplicationController
  include TeamsHelper
  include LeaguesHelper
  before_action :logged_in_user
  before_action :activated_user
  before_action :user_has_already_created_a_team, only: [:new, :create]
  before_action :set_team,                        only: [:show, :edit, :update]
  before_action :load_all_competitions,           only: [:new, :create, :edit, :update]
  before_action :load_all_competitors,            only: [:new, :create, :edit, :update]
  before_action :make_sure_correct_user_makes_transfers, only: [:edit, :update]
  before_action :make_sure_current_user_has_available_transfers, only: [:edit, :update]
  
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
    @captain_options = @picks.map { |pick| pick.competitor }.reject(&:is_favourite?)
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
    current_transfer_selections = current_selection - current_team_picks
    replaced_picks               = current_team_picks - current_selection

    @current_team_captain         = current_team_captain
    @current_captain_selection    = Competitor.find(team_selection_params[:currentCaptainId])

    @current_transfer_selections = Competitor.find(current_transfer_selections)
    @replaced_picks              = Competitor.find(replaced_picks)

    current_selection = Competitor.find(current_selection)
    @captain_options  = current_selection.reject(&:is_favourite?)

    if @captain_options.include?(@current_captain_selection)
      @current_captain_selection = @current_captain_selection
    else
      @current_captain_selection = @captain_options.find(&:available_for_transfer?)
    end

    @favourite_count  = current_selection.length - @captain_options.length

    if @current_team_captain.competition_id == @current_captain_selection.competition_id
      captain_transfer_value = 0
    else
      captain_transfer_value = 1
      @outbound_captain = @current_team_captain
      @inbound_captain = @current_captain_selection
    end

    @active_transfer_count = current_transfer_selections.length + captain_transfer_value
    @transfers_count = @active_transfer_count + current_user_team.transfers_made

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

  def make_sure_current_user_has_available_transfers
    unless current_user.can_make_transfers?
      flash[:danger] = 'You have used all of your transfers and cannot make anymore!'
      return redirect_to current_user.team 
    end
  end

  def make_sure_correct_user_makes_transfers
    unless @team == current_user.team
      flash[:danger] = 'You can only make transfers for your own team!'
      return redirect_to current_user.team 
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
