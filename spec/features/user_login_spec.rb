require 'rails_helper'

RSpec.feature "User log in", type: :feature do
  let(:user) { FactoryBot.build(:user) }
  
  xscenario "User visits /login, fills out the log in form. They are then taken to their dashboard" do
    sign_up(user)
    expect(current_path).to eq "/dashboard"
  end
end
