require 'rails_helper'

feature "User reviews a tattoo", %(
As a user
I want to rate and/or review a tattoo
So that I can share my stupid opinion with the world

  Acceptance Criteria
  [ ] I must visit the tattoo details page
  [ ] I must enter a rating of 1 through 5
  [ ] I may optionally enter a review of the tattoo
) do

  scenario 'visitor edits tattoo details' do
    tattoo = FactoryGirl.create(:tattoo, title: "Badass Celtic Armband")
    user = FactoryGirl.create(:user)
    login(user)

    visit tattoos_path
    click_link("Badass Celtic Armband")

    fill_in "Rating", with: 4
    fill_in "Review", with: "Not too shabby"
    click_button "Submit"
    expect(page).to have_content("Badass Celtic Armband")
    expect(page).to have_content(4)
    expect(page).to have_content("Not too shabby")
  end
end
