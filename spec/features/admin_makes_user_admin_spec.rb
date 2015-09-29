require 'rails_helper'

feature 'Admin makes a user an admin', %(
  As an admin
  I want to make a user an admin
  So that I could share the admin responsibilities

  Acceptance Criteria
  [x] I must be an admin to make a user admin
  [x] I must be on users index page
  [x] I must be presented with success notice
) do

  let(:admin) { FactoryGirl.create(:user, role: "admin") }

  before do
    5.times { FactoryGirl.create(:user) }
  end

  scenario 'Admin makes a user admin' do
    login(admin)
    user = FactoryGirl.create(:user)
    id = user.id
    visit users_path
    find("#admin-#{user.id}", 'Make Admin').click

    expect(page).to have_content("#{user.username} is now an admin.")
    expect(User.find(id).role).to eq("admin")
  end

  scenario 'User cannot make another user admin' do
    user = FactoryGirl.create(:user)
    other_user = User.first
    login(user)

    expect { page.driver.submit :post, user_make_admin_path(user), {} }.
      to raise_error(ActionController::RoutingError)
  end
end
