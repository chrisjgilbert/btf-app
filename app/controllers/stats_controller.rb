class StatsController < ApplicationController
  before_action :logged_in_user

  def index
    @competitions = Competition.all
  end
end
