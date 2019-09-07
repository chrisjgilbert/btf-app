require 'rails_helper'

RSpec.feature "User sign up", type: :feature do
  let(:user) { FactoryBot.build(:user) }

  scenario "with valid credentials" do
    valid_sign_up(user)
    expect(current_path).to eq "/dashboard"
    expect(page).to have_content('This is your dashboard, ' + user.first_name)
  end

  scenario "with invalid credentials" do
    invalid_sign_up(user)
    expect(current_path).to eq "/signup"
    expect(current_path).not_to eq "/dashboard"
    expect(page).not_to have_content('This is your dashboard, ' + user.first_name)
  end
end
