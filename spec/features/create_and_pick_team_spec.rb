require 'rails_helper'

RSpec.feature "Create team and picks", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  
  scenario "with valid credentials" do
    valid_log_in(user)
    expect(current_path).to eq "/dashboard"
    expect(page).to have_content "We notice you haven't made your picks yet. click here to do so."
    click_link "click here"
  end
end
