module AccountActivationsHelper

  def account_activation_success_flash_msg
    flash[:info] = 'Your BTF account has been successfully activated'
  end

  def account_activation_failure_flash_msg
    flash[:danger] = 'Invalid activation link'
  end
end
