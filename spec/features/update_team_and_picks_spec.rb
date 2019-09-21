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
    
    expect(page).to have_content("Your team has been created. Dont't forget you can come back and update your picks until midnight on 31st December 2019")
    click_link "Click here"
    
    expect(page).to have_selector('h1', text: 'Update team name and your picks')
    expect(page).to have_selector('p', text: 'You can come back and upate these before midnight on 31st Decemeber 2019')
    
    select "New Zealand", :from => "team_picks_attributes_0_competitor_id"
    select "Steve Smith", :from => "team_picks_attributes_1_competitor_id"
    select "Sergio Aguero", :from => "team_picks_attributes_2_competitor_id"
    fill_in :team_name, with: 'New Team Revised'
    click_button 'Submit'
    
    expect(page).to have_selector('h1', text: 'New Team Revised')
    expect(page).to have_selector('li', text: 'New Zealand for Rugby World Cup')
    expect(page).to have_selector('li', text: 'Steve Smith for Ashes')
    expect(page).to have_selector('li', text: 'Sergio Aguero for Golden Boot')
  end

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
    
    expect(page).to have_content("Your team has been created. Dont't forget you can come back and update your picks until midnight on 31st December 2019")
    click_link "Click here"
    
    expect(page).to have_selector('h1', text: 'Update team name and your picks')
    expect(page).to have_selector('p', text: 'You can come back and upate these before midnight on 31st Decemeber 2019')
    
    select "New Zealand", :from => "team_picks_attributes_0_competitor_id"
    select "Steve Smith", :from => "team_picks_attributes_1_competitor_id"
    select "Sergio Aguero", :from => "team_picks_attributes_2_competitor_id"
    fill_in :team_name, with: ''
    click_button 'Submit'
    
    expect(page).to have_content("Name can't be blank")
    expect(page).not_to have_selector('h1', text: 'New Team')
  end
end
