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
    tattoo = FactoryGirl.create(:tattoo)
    tattoo2 = FactoryGirl.create(:tattoo)
    tattoo3 = FactoryGirl.create(:tattoo)
    tattoo4 = FactoryGirl.create(:tattoo)

    visit tattoos_path
    expect(page).to have_content(tattoo.title)
    expect(page).to have_content(tattoo2.title)
    expect(page).to have_content(tattoo3.title)
    expect(page).to have_content(tattoo4.title)
  end

  scenario 'visitor views only 6 tattoos per page' do
    tattoo = FactoryGirl.create(:tattoo)
    tattoo2 = FactoryGirl.create(:tattoo)
    tattoo3 = FactoryGirl.create(:tattoo)
    tattoo4 = FactoryGirl.create(:tattoo)
    tattoo5 = FactoryGirl.create(:tattoo)
    tattoo6 = FactoryGirl.create(:tattoo)
    tattoo7 = FactoryGirl.create(:tattoo)
    tattoo8 = FactoryGirl.create(:tattoo)

    visit tattoos_path
    expect(page).to have_content(tattoo8.title)
    expect(page).to have_content(tattoo7.title)
    expect(page).to have_content(tattoo6.title)
    expect(page).to have_content(tattoo5.title)
    expect(page).to_not have_content(tattoo.title)
    expect(page).to_not have_content(tattoo2.title)

    visit '/?page=2'
    expect(page).to have_content(tattoo.title)
    expect(page).to have_content(tattoo2.title)
    expect(page).to_not have_content(tattoo4.title)
    expect(page).to_not have_content(tattoo3.title)
  end
end
