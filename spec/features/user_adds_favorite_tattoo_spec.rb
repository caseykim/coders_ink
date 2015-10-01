require 'rails_helper'

feature "User designates a tattoo as a favorite", %(
As a user
I want to list a tattoo as one of my favorites
So that I can see all of my favorite tattoos on a single page

  Acceptance Criteria
  [x] I must be logged in to mark a tattoo as a favorite
  [x] I must click on a button to designate the tattoo as favorite
  [x] I must receive a success message
  [x] I must remain on the same page
) do

  context 'user adds tattoo to favorites list' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:tattoo) { FactoryGirl.create(:tattoo) }

    scenario 'user makes tattoo a favorite' do
      login(user)
      visit tattoo_path(tattoo)
      click_button 'Favorite'

      expect(page).to have_content("Tattoo added to your favorites.")
      expect(page).to have_css("img[src*='#{tattoo.url}']")
    end

    scenario 'user tries to make tattoo a favorite without login' do
      visit tattoo_path(tattoo)
      expect(page).to_not have_content('Favorite')
    end
  end
end
