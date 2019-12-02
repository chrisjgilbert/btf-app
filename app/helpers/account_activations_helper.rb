module AccountActivationsHelper

  def account_activation_success_flash_msg
    flash[:info] = 'Your BTF account has been successfully activated'
  end

  def account_activation_failure_flash_msg
    flash[:danger] = 'Invalid activation link'
  end

  def account_activation_safety_flash_msg
    flash[:info] = 'Please login'
  end
end
