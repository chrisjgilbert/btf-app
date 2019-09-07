require 'rails_helper'
require_relative '../support/users_controller_spec_helper.rb'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.build(:user) }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context 'with valid user sign up params' do
      it "redirects to user dashboard" do
        post :create, params: { user: valid_user_signup_params(user) }
        expect(response).to redirect_to dashboard_path(user)
      end
      it "creates a new user account with valid attributes" do
        expect { post :create, params: { user: valid_user_signup_params(user) } }.to change { User.count }.by(1)
        new_user = User.last
        expect(new_user.first_name).to eq user.first_name
        expect(new_user.last_name).to eq user.last_name
        expect(new_user.email).to eq user.email
      end
    end

    context 'with invalid params' do
      xit "renders the signup form again" do
        post :create, params: {
                          user: {
                            first_name: user.first_name,
                            last_name: user.last_name,
                            username: user.username,
                            email: user.email,
                            password: user.password
                                }
                              }
        expect(response).to render_template "new"
      end
  
      xit "won't create an account if invalid params" do
        expect { invalid_post }.not_to change { User.count }
      end
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
