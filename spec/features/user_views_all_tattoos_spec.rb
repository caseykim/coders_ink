require 'rails_helper'

feature "User views all tattoos", %(
  As a user
  I want to view recently posted tattoos
  So that I could read or write reviews for tattoo

  Acceptance Criteria
  [x] I must see the name of each tattoo posting
  [x] I must see the tattoos listed in order, most recently posted first
  [x] I must see only 6 tattoo posting per page
) do

  scenario 'visitor views tattoos' do
    FactoryGirl.create(:tattoo, title: "Tattoo1")
    FactoryGirl.create(:tattoo, title: "Tattoo2")
    FactoryGirl.create(:tattoo, title: "Tattoo3")
    FactoryGirl.create(:tattoo, title: "Tattoo4")

    visit tattoos_path
    expect(page).to have_content("Tattoo1")
    expect(page).to have_content("Tattoo2")
    expect(page).to have_content("Tattoo3")
    expect(page).to have_content("Tattoo4")
  end

  scenario 'visitor views only 6 tattoos per page' do
    FactoryGirl.create(:tattoo, title: "Tattoo1")
    FactoryGirl.create(:tattoo, title: "Tattoo2")
    FactoryGirl.create(:tattoo, title: "Tattoo3")
    FactoryGirl.create(:tattoo, title: "Tattoo4")
    FactoryGirl.create(:tattoo, title: "Tattoo5")
    FactoryGirl.create(:tattoo, title: "Tattoo6")
    FactoryGirl.create(:tattoo, title: "Tattoo7")
    FactoryGirl.create(:tattoo, title: "Tattoo8")

    visit tattoos_path
    expect(page).to have_content("Tattoo8")
    expect(page).to have_content("Tattoo7")
    expect(page).to have_content("Tattoo6")
    expect(page).to have_content("Tattoo5")
    expect(page).to_not have_content("Tattoo1")
    expect(page).to_not have_content("Tattoo2")

    visit 'tattoos/?page=2'
    expect(page).to have_content("Tattoo1")
    expect(page).to have_content("Tattoo2")
    expect(page).to_not have_content("Tattoo4")
    expect(page).to_not have_content("Tattoo3")
  end
end
