require 'rails_helper'

RSpec.feature "Create team", type: :feature do
  let(:user) { FactoryBot.build(:user) }

  scenario "with valid credentials" do
    valid_sign_up(user)
    expect(current_path).to eq "/dashboard"
    expect(page).to have_content "We notice you haven't made your picks yet. click here to do so."
    click_link "click here"
    
    fill_in :team_name, with: 'New Team'
    click_button 'Submit'

    expect(page).to have_selector('h1', text: 'New Team')
  end
end
