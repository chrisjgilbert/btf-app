require 'rails_helper'
require_relative '../support/users_controller_spec_helper.rb'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.build(:user) }

  describe "GET #new" do
    it "returns http success and renders `new` form" do
      get :new
      expect(response).to render_template "new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context 'with valid user sign up params' do
      it "redirects to user dashboard" do
        post :create, params: { user: valid_user_signup_params(user) }
        expect(response).to redirect_to dashboard_path
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
      it "renders the signup form again" do
        post :create, params: { user: invalid_user_signup_params }
        expect(response).to render_template "new"
      end
      
      it "won't create an account if invalid params" do
        post :create, params: { user: invalid_user_signup_params }
        expect { post :create, params: { user: invalid_user_signup_params } }.not_to change { User.count }
      end
    end
  end
end
