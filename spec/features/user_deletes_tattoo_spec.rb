require 'rails_helper'

feature 'User deletes a tattoo posting', %(
  As a user
  I want to delete my tattoo
  So that I can remove it from my profile page and the site

  Acceptance Criteria
  [x] I must be the owner of the post to delete
  [x] I must visit the tattoo details page or my profile page
  [x] I must click an Delete Tattoo link or button
  [x] I must get a success alert for the deletion
) do

  let(:user) { FactoryGirl.create(:user_with_tattoos) }

  context "user is not signed in" do
    scenario "users not logged in cannot edit tattoos" do
      tattoo = user.tattoos.first
      visit tattoo_path(tattoo)

      expect(page).to_not have_link('Delete')
    end
  end

  context "user is signed in" do

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario "user cannot delete other user's tattoo posting" do
    another_user = FactoryGirl.create(:user_with_tattoos)
    tattoo = another_user.tattoos.first
    visit tattoo_path(tattoo)

    expect(page).to_not have_link('Delete')
  end

  scenario 'user deletes a tattoo posting from tattoo details page' do
    tattoo = user.tattoos.last
    visit tattoo_path(tattoo)
    click_link 'Delete'

    expect(page).to have_content('Tattoo deleted successfully.')
  end

  scenario 'user deletes a tattoo posting from my profile page' do
    id_css = "#delete-#{user.tattoos.first.id}"
    visit user_path(user)
    find(id_css, 'Delete').click

    expect(page).to have_content('Tattoo deleted successfully.')
  end
  end
end
