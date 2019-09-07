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

def invalid_sign_up(user, invalid_credential)
  visit "/signup"
  within "form#new_user" do
    case :invalid_credential
    when :no_first_name
      fill_in "user_first_name", with: ''
      fill_in "user_last_name", with: user.last_name
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password
    when :no_last_name
      fill_in "user_first_name", with: user.first_name
      fill_in "user_last_name", with: ''
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password
    when :invalid_email
      fill_in "user_first_name", with: user.first_name
      fill_in "user_last_name", with: user.last_name
      fill_in "user_email", with: 'chris.com'
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password
    when :no_email
      fill_in "user_first_name", with: user.first_name
      fill_in "user_last_name", with: user.last_name
      fill_in "user_email", with: ''
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password
    when :no_password
      fill_in "user_first_name", with: user.first_name
      fill_in "user_last_name", with: user.last_name
      fill_in "user_email", with: user.email
      fill_in "user_password", with: ''
      fill_in "user_password_confirmation", with: user.password
    when :no_password_confirmation
      fill_in "user_first_name", with: user.first_name
      fill_in "user_last_name", with: user.last_name
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: ''
    when :mismatching_passwords
      fill_in "user_first_name", with: user.first_name
      fill_in "user_last_name", with: user.last_name
      fill_in "user_email", with: user.email
      fill_in "user_password", with: 'password11'
      fill_in "user_password_confirmation", with: 'password2'
    when :short_password
      fill_in "user_first_name", with: user.first_name
      fill_in "user_last_name", with: user.last_name
      fill_in "user_email", with: user.email
      fill_in "user_password", with: 'pass'
      fill_in "user_password_confirmation", with: 'pass'
    end
  click_button "Sign up"
  end
end

def valid_log_in(user)
  visit "/login"
  within "form" do
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    click_button "Log in"
  end
end

def invalid_log_in(user)
  visit "/login"
  within "form" do
    fill_in "session_email", with: user.email
    fill_in "session_password", with: 'blah'
    click_button "Log in"
  end
end
