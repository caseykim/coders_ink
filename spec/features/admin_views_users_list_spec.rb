require 'rails_helper'

feature 'Admin views a list of users', %(
  As an admin
  I want to view the list of users
  So that I can delete a malicious user

  Acceptance Criteria
  [x] I must see a list of users
  [x] I must see user's username
  [x] I must see user's email
) do

  let(:admin) { FactoryGirl.create(:user, role: "admin") }

  before do
    5.times { FactoryGirl.create(:user) }
  end

  scenario "Admin sees other users' usernames and email" do
    login(admin)
    visit users_path

    User.all.each do |user|
      expect(page).to have_content(user.username)
      expect(page).to have_content(user.email)
    end
  end

  scenario "Admin sees other users' profile photos" do
    login(admin)
    visit users_path

    User.all.each do |user|
      expect(page).to have_css("img[src*='#{user.profile_photo}']")
    end
  end

  scenario "Admin sees other users' profile photos" do
    login(admin)
    visit users_path

    User.all.each do |user|
      expect(page).to have_css("img[src*='#{user.profile_photo}']")
    end
  end

  scenario "User cannot see the list of users" do
    user = FactoryGirl.create(:user)
    login(user)

    expect{ visit users_path }.to raise_error(ActionController::RoutingError)
  end

  scenario "Admin sees a maximum of 18 users per page" do
    20.times { FactoryGirl.create(:user) }
    users = User.all
    login(admin)
    visit users_path

    expect(page).to have_content(users.first.username)
    expect(page).to have_content(users.first.username)
    expect(page).to_not have_content(users.last.username)
    expect(page).to_not have_content(users.last.username)

    visit 'users/?page=2'

    expect(page).to have_content(users.last.username)
    expect(page).to have_content(users.last.username)
    expect(page).to_not have_content(users.first.username)
    expect(page).to_not have_content(users.first.username)
  end
end
