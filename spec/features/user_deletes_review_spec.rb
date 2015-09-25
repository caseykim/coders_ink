require 'rails_helper'

feature 'User deletes a review', %(
  As a user
  I want to delete my review
  So that I can remove it from my profile page and the site

  Acceptance Criteria
  [] I must be the owner of the review to delete
  [] I must visit the tattoo details page
  [] I must click a Delete Review link or button
  [] I must get a success alert for the deletion
) do

  let(:user) { FactoryGirl.create(:user_with_tattoos) }
  let(:another_user) { FactoryGirl.create(:user_with_tattoos) }

  before do
    login(user)
  end

  scenario "user cannot delete other user's review" do
    tattoo = user.tattoos.first
    FactoryGirl.create(:review, user: another_user, tattoo: tattoo)
    visit tattoo_path(tattoo)

    expect(page).to_not have_content('Delete Review')
  end

  scenario 'user deletes a tattoo posting from tattoo details page' do
    tattoo = another_user.tattoos.last
    FactoryGirl.create(:review, user: user, tattoo: tattoo)
    visit tattoo_path(tattoo)
    click_button 'Delete Review'

    expect(page).to have_content('Review deleted successfully.')
  end

end
