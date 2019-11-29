module UsersHelper
  def account_activation_email_send_flash_message(user)
    flash[:info] = "An email has been sent to #{user.email}. Follow the link in the email to activate your account. You may need to check your junk mail"
  end
end
