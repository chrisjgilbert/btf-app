class LeaguesController < ApplicationController
  def new
  end

  def create
  end

  def index
  end

  def show
    @league = League.find(params[:id])
  end
end
