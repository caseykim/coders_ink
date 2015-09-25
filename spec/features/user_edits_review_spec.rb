require 'rails_helper'

feature 'User edits a review posting', %(
  As a user
  I want to edit my review
  So that I can change my mind on a tattoo

  Acceptance Criteria
  [ ] I must be the owner of the review to edit
  [ ] I must visit the tattoo details page
  [ ] I must click an Edit Review link or button
  [ ] I must get a success alert for the update
  [ ] I must get an error alert if the update fails
) do

  let(:user) { FactoryGirl.create(:user_with_tattoos) }
  let(:another_user) { FactoryGirl.create(:user_with_tattoos) }

  before do
    login(user)
  end

  scenario "user cannot edit other user's review" do
    tattoo = user.tattoos.first
    FactoryGirl.create(:review, user: another_user, tattoo: tattoo)
    visit tattoo_path(tattoo)

    expect(page).to_not have_content('Edit Review')
  end

  scenario 'user edits a review from tattoo details page' do
    tattoo = another_user.tattoos.last
    FactoryGirl.create(:review, user: user, tattoo: tattoo)
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
    FactoryGirl.create(:review, user: user, tattoo: tattoo)
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
