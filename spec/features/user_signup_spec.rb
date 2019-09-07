require 'rails_helper'

RSpec.feature "User sign up", type: :feature do
  let(:user) { FactoryBot.build(:user) }

  scenario "with valid credentials" do
    valid_sign_up(user)
    expect(current_path).to eq "/dashboard"
    expect(page).to have_content('This is your dashboard, ' + user.first_name)
  end

  scenario "with invalid credentials: no first name" do
    invalid_sign_up(user, :no_first_name)
    expect(current_path).to eq "/signup"
    expect(page).to have_content("First name can't be blank")
    expect(current_path).not_to eq "/dashboard"
  end

  scenario "with invalid credentials: no_last_name" do
    invalid_sign_up(user, :no_last_name)
    expect(current_path).to eq "/signup"
    expect(page).to have_content("Last name can't be blank")
    expect(current_path).not_to eq "/dashboard"
  end

  scenario "with invalid credentials: invalid_email" do
    invalid_sign_up(user, :invalid_email)
    expect(current_path).to eq "/signup"
    expect(page).to have_content("Email is invalid")
    expect(current_path).not_to eq "/dashboard"
  end

  scenario "with invalid credentials: no_email" do
    invalid_sign_up(user, :no_email)
    expect(current_path).to eq "/signup"
    expect(page).to have_content("Email can't be blank")
    expect(current_path).not_to eq "/dashboard"
  end

  scenario "with invalid credentials: no_password" do
    invalid_sign_up(user, :no_password)
    expect(current_path).to eq "/signup"
    expect(page).to have_content("Password can't be blank")
    expect(current_path).not_to eq "/dashboard"
  end

  xscenario "with invalid credentials: no_password_confirmation" do
    invalid_sign_up(user, :no_password_confirmation)
    expect(current_path).to eq "/signup"
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(current_path).not_to eq "/dashboard"
  end

  xscenario "with invalid credentials: mismatching_passwords" do
    invalid_sign_up(user, :mismatching_passwords)
    expect(current_path).to eq "/signup"
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(current_path).not_to eq "/dashboard"
  end

  scenario "with invalid credentials: short_password" do
    invalid_sign_up(user, :short_password)
    expect(current_path).to eq "/signup"
    expect(page).to have_content("Password is too short (minimum is 6 characters)")
    expect(current_path).not_to eq "/dashboard"
  end
end
