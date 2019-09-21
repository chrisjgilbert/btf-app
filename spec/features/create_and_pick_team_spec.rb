require 'rails_helper'

RSpec.feature "Create team and picks", type: :feature do
  let(:user) { FactoryBot.build(:user) }
  fixtures :competitions
  fixtures :competitors

  scenario "with valid credentials" do
    valid_sign_up(user)
    expect(current_path).to eq "/dashboard"
    expect(page).to have_content "We notice you haven't made your picks yet. click here to do so."
    click_link "click here"
    
    fill_in :team_name, with: 'New Team'

    select "England", :from => "team_picks_attributes_0_competitor_id"
    select "Steve Smith", :from => "team_picks_attributes_1_competitor_id"
    select "Harry Kane", :from => "team_picks_attributes_2_competitor_id"
    click_button 'Submit'

    expect(page).to have_selector('h1', text: 'New Team')
    expect(page).to have_selector('li', text: 'England for Rugby World Cup')
    expect(page).to have_selector('li', text: 'Steve Smith for Ashes')
    expect(page).to have_selector('li', text: 'Harry Kane for Golden Boot')
  end

  scenario "with invalid credentials" do
    valid_sign_up(user)
    expect(current_path).to eq "/dashboard"
    expect(page).to have_content "We notice you haven't made your picks yet. click here to do so."
    click_link "click here"
    
    fill_in :team_name, with: ''
    click_button 'Submit'
    expect(page).to have_content("Name can't be blank")
    expect(page).not_to have_selector('h1', text: 'New Team')
  end
end
