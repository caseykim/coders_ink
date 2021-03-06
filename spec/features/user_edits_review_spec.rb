require 'rails_helper'

feature 'User edits a review posting', %(
  As a user
  I want to edit my review
  So that I can change my mind on a tattoo

  Acceptance Criteria
  [x] I must be the owner of the review to edit
  [x] I must visit the tattoo details page
  [x] I must click an Edit Review link or button
  [x] I must get a success alert for the update
  [x] I must get an error alert if the update fails
) do

  let(:user) { FactoryGirl.create(:user_with_tattoos) }
  let(:another_user) { FactoryGirl.create(:user_with_tattoos) }
  let(:another_user_review) do
    FactoryGirl.create(:review, user: another_user, tattoo: user.tattoos.first)
  end
  let(:user_review) do
    FactoryGirl.create(:review, user: user, tattoo: another_user.tattoos.last)
  end

  context "user is not signed in" do
    scenario "users not logged in cannot edit reviews" do
      tattoo = user.tattoos.first
      visit tattoo_path(tattoo)

      expect(page).to_not have_content('Edit Review')
    end
  end

  context "user is signed in" do

    before do
      login(user)
      another_user
      another_user_review
      user_review
    end

    scenario "user cannot edit other user's review" do
      tattoo = user.tattoos.first
      visit tattoo_path(tattoo)

      expect(page).to_not have_content('Edit Review')
    end

    scenario 'user edits a review from tattoo details page' do
      tattoo = another_user.tattoos.last
      visit tattoo_path(tattoo)
      click_link 'Edit Review'
      expect(page).to have_content('Update Review')
      expect(page).to have_content('Rating')
      expect(page).to have_content('Review')

      fill_in 'Rating', with: "5"
      fill_in 'Review', with: "WHOO"
      click_button 'Submit'
      expect(page).to have_content('Review successfully updated.')
      expect(page).to have_content('5')
      expect(page).to have_content('WHOO')
    end

    scenario 'user edits a review with an invalid form' do
      tattoo = another_user.tattoos.last
      visit tattoo_path(tattoo)
      click_link 'Edit Review'
      expect(page).to have_content('Update Review')
      expect(page).to have_content('Rating')
      expect(page).to have_content('Review')

      fill_in 'Rating', with: "500"
      click_button 'Submit'
      expect(page).to have_content('Rating Must be 1 through 5')
    end

  end

end
