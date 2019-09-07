# frozen_string_literal: true

def valid_sign_up(user)
  visit "/signup"
  within "form#new_user" do
    fill_in "user_first_name", with: user.first_name
    fill_in "user_last_name", with: user.last_name
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    fill_in "user_password_confirmation", with: user.password
    click_button "Sign up"
  end
end

def invalid_sign_up(user)
  visit "/signup"
  within "form#new_user" do
    fill_in "user_first_name", with: user.first_name
    fill_in "user_last_name", with: user.last_name
    fill_in "user_email", with: 'invalidemail'
    fill_in "user_password", with: 'password11'
    fill_in "user_password_confirmation", with: 'password2'
    click_button "Sign up"
  end
end

def sign_in(user)
  visit "/sign_in"
  within "#sign-in-form" do
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "Log in"
  end
end
