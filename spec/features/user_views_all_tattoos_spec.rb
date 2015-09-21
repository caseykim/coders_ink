require 'rails_helper'

feature "User views all tattoos", %(
  As a user
  I want to view recently posted tattoos
  So that I could read or write reviews for tattoo

  Acceptance Criteria
  [ ] I must see the name of each tattoo posting
  [ ] I must see the tattoos listed in order, most recently posted first
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

end
