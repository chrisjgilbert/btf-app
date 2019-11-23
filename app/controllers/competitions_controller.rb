class CompetitionsController < ApplicationController
  def show
    @competition = Competition.find(params[:id])
  end
end
