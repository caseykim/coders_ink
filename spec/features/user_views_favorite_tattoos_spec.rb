require 'rails_helper'

feature "User views all favorite tattoos", %(
As a user
I want to view a list of my favorite tattoos
So that I can see all of them at once

  Acceptance Criteria
  [x] I must be logged in to view my favorites
  [x] I must be able to access my favorites wherever I am on the site
  [x] I must be able to view the favorites by clicking the favorites link
  [x] I must see my favorite tattoos on my favorites show page
) do

  context 'user views their favorite list' do
    let!(:user1) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }
    let!(:t1) { FactoryGirl.create(:tattoo, user: user2) }
    let!(:favorite1) { FactoryGirl.create(:favorite, user: user1, tattoo: t1) }

    scenario 'user views favorites page' do
      login(user1)
      visit tattoos_path

      click_link 'Favorites'

      expect(page).to have_content("Favorite Tattoos")
      url = user1.favorites.first.tattoo.url
      expect(page).to have_content(user1.favorites.first.tattoo.title)
      expect(page).to have_css("img[src*='#{url}']")
    end

    scenario 'user tries to visit favorites before logging in' do
      visit tattoos_path
      expect(page).to_not have_content('Favorites')
    end
  end
end
