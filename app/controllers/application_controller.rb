class ApplicationController < ActionController::Base
  include SessionsHelper

  rescue_from ActiveRecord::RecordNotFound, with: :error_404
  rescue_from ActionController::RoutingError, with: :error_404

  def error_404
    render 'errors/not_found', status: 404
  end
end
