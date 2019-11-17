require 'rails_helper'

RSpec.describe StaticController, type: :controller do

  describe "GET #rules_and_guidance" do
    it "returns http success" do
      get :rules_and_guidance
      expect(response).to have_http_status(:success)
    end
  end

end
