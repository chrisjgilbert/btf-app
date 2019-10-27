module AccountActivationsHelper

  def account_activation_success_flash_msg
    flash[:success] = 'Account successfully activated. Welcome to BTF!'
  end

  def account_activation_failure_flash_msg
    flash[:danger] = 'Invalid activation link'
  end
end
