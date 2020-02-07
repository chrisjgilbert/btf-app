require 'rails_helper'

RSpec.describe AdminController, type: :controller do

  describe "GET #points" do
    it "returns http success" do
      get :points
      expect(response).to have_http_status(:success)
    end
  end

end
