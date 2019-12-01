class StaticController < ApplicationController
  before_action :logged_in_user, except: [:root]
  def rules_and_guidance
  end

  def blog
  end

  def welcome
  end

  def payment
    @payment_link = 'https://monzo.me/danielwilliams502/20.00?d=BTF%202020%20(type%20email%20address%20here)%20'.html_safe
  end
end
