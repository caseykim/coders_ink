require 'rails_helper'

feature "User reviews a tattoo", %(
As a user
I want to rate and/or review a tattoo
So that I can share my stupid opinion with the world

  Acceptance Criteria
  [√] I must be logged to review a tattoo
  [√] I must visit the tattoo details page
  [√] I must enter a rating of 1 through 5
  [√] I may optionally enter a review of the tattoo
  [√] I may not review my own tattoo
) do

  context "user is not logged in" do

    scenario 'user tries to review a tattoo' do
      celtic_user = FactoryGirl.create(:user)
      FactoryGirl.create(:tattoo, title: "Celtic Armband", user: celtic_user)
      visit tattoos_path
      click_link("Celtic Armband")

      expect(page).to_not have_button("Submit")
    end
  end

  context "user is logged in" do

    before do
      celtic_user = FactoryGirl.create(:user)
      FactoryGirl.create(:tattoo, title: "Celtic Armband", user: celtic_user)
      user = FactoryGirl.create(:user_with_tattoos)
      login(user)

      visit tattoos_path
      click_link("Celtic Armband")
    end

    scenario "user reviews a tattoo" do
      fill_in "Rating", with: 4
      fill_in "Review", with: "Not too shabby"
      click_button "Submit"
      expect(page).to have_content("Celtic Armband")
      expect(page).to have_content(4)
      expect(page).to have_content("Not too shabby")
    end

    scenario "user fills out form incorrectly" do
      click_button "Submit"
      errors = "Rating can't be blank, Rating is not a number,
        Rating Must be 1 through 5"
      expect(page).to have_content(errors)
    end

    scenario "user tries to review their own tattoo" do
      user = User.last
      visit tattoo_path(user.tattoos.last)
      expect(page).to_not have_button("Submit")
    end
  end
end
