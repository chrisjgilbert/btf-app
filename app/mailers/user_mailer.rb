class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user

    mail to: user.email, subject: 'BTF Account Activation'
  end

  def password_reset(user)
    @user = user

    mail to: user.email, subject: 'BTF account password reset'
  end
end
