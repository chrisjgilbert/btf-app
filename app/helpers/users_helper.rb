module UsersHelper
  def account_activation_email_send_flash_message(user)
    flash[:info] = "An email has been sent to #{user.email}. Please activate your account."
  end
end
