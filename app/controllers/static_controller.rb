class StaticController < ApplicationController
  before_action :logged_in_user, except: [:root, :contact]
  def rules_and_guidance
    @payment_link = 'https://monzo.me/alexanderwall2/20.00?d=BTF%202020%20(please%20insert%20email%20address%20here)%20'.html_safe
  end

  def blog
  end

  def welcome
  end

  def payment
    @payment_link = 'https://monzo.me/alexanderwall2/20.00?d=BTF%202020%20(please%20insert%20email%20address%20here)%20'.html_safe
  end

  def contact
  end
end
