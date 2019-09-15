require 'rails_helper'

RSpec.feature "User log out", type: :feature do
  let(:not_signed_up_user) { FactoryBot.build(:user) }
  let(:signed_up_user) { FactoryBot.create(:user) }
  
  scenario "sign up then log out" do
    valid_sign_up(not_signed_up_user)
    expect(current_path).to eq "/dashboard"
    expect(page).to have_content('This is your dashboard, ' + not_signed_up_user.first_name)
    logout
    expect(current_path).to eq "/login"
  end
  
  scenario "sign in then log out" do
    valid_log_in(signed_up_user)
    expect(current_path).to eq "/dashboard"
    expect(page).to have_content('This is your dashboard, ' + signed_up_user.first_name)
    logout
    expect(current_path).to eq "/login"
  end
end
