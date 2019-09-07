require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with an existing user and valid params' do
      it 'it authenticates the user and logs them in' do
        expect(subject).to receive(:log_in).with(user)
        post :create, params: { session: { email: user.email, password: user.password } }
        expect(response).to redirect_to dashboard_path
      end
    end

    context 'with invalid params' do
      it 're-renders the `new` form' do
        post :create, params: { session: { email: user.email, password: nil } }
        expect(response).to render_template "new"
      end
    end

    context 'without an existing user' do
      it 're-renders the `new` form' do
        post :create, params: { session: { email: nil, password: nil } }
        expect(response).to render_template "new"
      end
    end
  end

  describe "GET #destroy" do
    context 'when a user is logged in' do
      it 'logs the user out' do
        allow(subject).to receive(:logged_in?).and_return(true)
        expect(subject).to receive(:log_out)
        get :destroy
      end
    end
    it "returns http success" do
      get :destroy
      expect(response).to redirect_to login_path
    end
  end
end
