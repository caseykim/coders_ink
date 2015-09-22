require 'rails_helper'

feature "User views user detail page", %(
  As a user
  I want to see detail page for a user
  So that I can see the postings by the user

  Acceptance Criteria
  [x] I must see the user's detailed information
  [x] I must see all tattoos posted by the user
  [x] I must not see any other user's information
  [x] I must not see any other user's tattoo postings
) do
  let(:user) { FactoryGirl.create(:user_with_tattoos) }

  scenario "user sees the user's detailed information" do
    visit user_path(user)

    expect(page).to have_content(user.username)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.avatar)
  end

  scenario "user does not see other user's information" do
    another_user = FactoryGirl.create(:user)
    visit user_path(user)

    expect(page).to_not have_content(another_user.username)
    expect(page).to_not have_content(another_user.email)
  end

  scenario "user sees all tattoo postings by the user" do
    count = user.tattoos.count
    visit user_path(user)

    expect(page).to have_css('.tattoo', count: count)
    expect(page).to have_content(user.tattoos.first.title)
    expect(page).to have_content(user.tattoos.last.url)
  end

  scenario "user does not see other user's tattoo posting" do
    another_user = FactoryGirl.create(:user_with_tattoos)
    visit user_path(user)

    expect(page).to_not have_content(another_user.tattoos.first.title)
  end
end
