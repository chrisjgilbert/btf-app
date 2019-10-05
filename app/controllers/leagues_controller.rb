class LeaguesController < ApplicationController
  def index
    @leagues = League.all
  end

  def new
  end

  def create
  end


  def show
    @league = League.find(params[:id])
  end
end
