class StatsController < ApplicationController
  def index
    @competitions = Competition.all
  end
end
