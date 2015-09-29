require 'rails_helper'

feature "Admin deletes an obnoxious user", %(
  As an admin
  I want to delete a user
  So that I can delete obnoxious users' accounts

  Acceptance Criteria
  [x] I must be on the users index page
  [x] I must click a button 'Delete' to delete a user
  [x] I must be presented with success message and redirected to index
) do

  let(:admin) { FactoryGirl.create(:user, role: "admin") }

  before do
    5.times { FactoryGirl.create(:user) }
  end

  scenario "I must see a button 'Delete' on users index page" do
    login(admin)
    visit users_path
    first_user = User.first
    find("##{first_user.id}", "Delete").click

    expect(page).to have_content('User deleted successfully.')
    User.all.each do |user|
      expect(page).to have_css("img[src*='#{user.profile_photo}']")
    end
  end

  scenario "User has no access to delete the account" do
    user = FactoryGirl.create(:user)
    other_user = User.first
    login(user)

    expect{ page.driver.submit :delete, "/users/#{other_user.id}", {} }.
      to raise_error(ActionController::RoutingError)
  end

end
