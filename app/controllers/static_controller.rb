class StaticController < ApplicationController
  before_action :logged_in_user, except: [:root]
  def rules_and_guidance
  end

  def blog
  end

  def welcome
  end
end
