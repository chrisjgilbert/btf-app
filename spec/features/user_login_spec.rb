require 'rails_helper'

RSpec.feature "User log in", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  
  scenario "with valid credentials" do
    valid_log_in(user)
    expect(current_path).to eq "/dashboard"
    expect(page).to have_content('This is your dashboard, ' + user.first_name)
  end
  
  scenario "with invalid credentials" do
    invalid_log_in(user)
    expect(current_path).to eq "/login"
    expect(page).not_to have_content('This is your dashboard, ' + user.first_name)
  end
end
