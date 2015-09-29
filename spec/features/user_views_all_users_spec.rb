require 'rails_helper'

feature "User views all users", %(
  As a user
  I want to see a list of users
  So that I get to know all users

  Acceptance Criteria
  [x] I must see all users' usernames
  [x] I must see all users' profile photos
) do
  before do
    5.times { FactoryGirl.create(:user) }
  end

  scenario "user sees other users' usernames" do
    visit users_path

    User.all.each do |user|
      expect(page).to have_content(user.username)
    end
  end

  scenario "user sees other users' profile photos" do
    visit users_path

    User.all.each do |user|
      expect(page).to have_css("img[src*='#{user.profile_photo}']")
    end
  end

end
