def valid_user_signup_params(user)
  {
    first_name: user.first_name,
    last_name: user.last_name,
    email: user.email,
    password: user.password
  }
end

def invalid_user_signup_params
  {
    first_name: '',
    last_name: '',
    email: 'chris.com',
    password: ''
  }
end
