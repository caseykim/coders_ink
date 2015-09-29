require 'rails_helper'

feature "User searches for a tattoo", %(
  As a user
  I want to search for a tattoo name
  So that I can view all tattoos matching my search

  Acceptance Criteria
  [ ] I must be displayed with all the tattoos that match my search
  [ ] I must see the name of each tattoo posting
) do

  scenario 'visitor searches for a tattoo' do
    tattoo = FactoryGirl.create(:tattoo)
    tattoo2 = FactoryGirl.create(:tattoo)
    tattoo3 = FactoryGirl.create(:tattoo)
    tattoo4 = FactoryGirl.create(:tattoo)
    tattoo5 = FactoryGirl.create(:tattoo, title: "Blarg")

    visit tattoos_path
    fill_in "Search Tattoos", with: "Celtic"

    click_button "Search"
    
    expect(page).to have_content(tattoo.title)
    expect(page).to have_content(tattoo2.title)
    expect(page).to have_content(tattoo3.title)
    expect(page).to have_content(tattoo4.title)

    expect(page).to_not have_content(tattoo5.title)
  end

end
