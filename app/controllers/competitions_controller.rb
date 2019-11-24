class CompetitionsController < ApplicationController
  before_action :logged_in_user

  def show
    @competition = Competition.find(params[:id])
  end
end
