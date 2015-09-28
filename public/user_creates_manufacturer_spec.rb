require 'rails_helper'

feature 'user creates a manufacturer', %Q{
  As a signed up user
  I want to create a manufacturer
  So that I can add them to the manufacturer listings
} do
  scenario 'enter a manufacturer' do
    user = FactoryGirl.create(:user)
    login(user)

    visit new_manufacturer_path

    fill_in 'Name', with: 'Motorola'
    fill_in 'Country', with: 'USA'
    click_button 'Submit'
    expect(page).to have_content('name: Motorola')
    expect(page).to have_content('country: USA')
  end

  scenario 'submit a blank form' do
    user = FactoryGirl.create(:user)
    login(user)

    visit new_manufacturer_path

    click_button 'Submit'
    expect(page).to have_content("Name can't be blank, Country can't be blank Enter a Manufacturer Name Country")
  end

  scenario 'submit a form with a blank name' do
    user = FactoryGirl.create(:user)
    login(user)

    visit new_manufacturer_path

    fill_in 'Country', with: 'USA'
    click_button 'Submit'
    expect(page).to have_content("Name can't be blank")
  end

  scenario 'submit a form with a blank name' do
    user = FactoryGirl.create(:user)
    login(user)

    visit new_manufacturer_path

    fill_in 'Name', with: 'Motorola'
    click_button 'Submit'
    expect(page).to have_content("Country can't be blank")
  end
end
