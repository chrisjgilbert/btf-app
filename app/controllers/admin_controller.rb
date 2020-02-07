class AdminController < ApplicationController
  def points
    @competitors ||= Competitor.all
  end

  def award_points
    competitor = Competitor.find(points_params[:competitor_id])
    if competitor.update(points: points_params[:awarded_points])
      redirect_to admin_points_path
      flash[:success] = "#{points_params[:awarded_points]} points awarded to #{competitor.name}!"
    else
      redirect_to admin_points_path
      flash[:danger] = "Something went wrong!"
    end
  end

  def update_all_points
    Team.calculate_all_points
    redirect_to admin_points_path
    flash[:success] = "Points updated!"
  end

  private

  def points_params
    params.require(:points).permit(:competitor_id, :awarded_points)
  end
end
