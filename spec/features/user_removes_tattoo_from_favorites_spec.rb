require 'rails_helper'

feature "User removes tattoo from favorites", %(
As a user
I want to remove a tattoo's designation as a favorite
So that is no longer marked as one of my favorites

  Acceptance Criteria
  [x] I must be logged in to delete a tattoo from my favorites
  [x] I must visit my favorites show page
  [x] I must click on a button to remove the tattoo from favorites
) do

  context 'user removes tattoo from favorites list' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:tattoo) { FactoryGirl.create(:tattoo) }

    scenario 'user removes a favorite' do
      login(user)
      visit tattoo_path(tattoo)
      click_button 'Favorite'
      click_button 'Favorite'

      expect(page).to have_content("Tattoo removed from your favorites.")
      click_link 'Favorites'
      expect(page).to_not have_css("img[src*='#{tattoo.url}']")
    end

    scenario 'user tries to make tattoo a favorite without login' do
      visit tattoo_path(tattoo)
      expect(page).to_not have_content('Favorite')
    end
  end
end
