require 'rails_helper'

feature 'Admin makes an admin a regular user', %(
  As an admin
  I want to make remove another admin's permissions
  So they can't mess anything else up

  Acceptance Criteria
  [x] I must be an admin to remove an admin
  [x] I must be on users index page
  [x] I must be presented with success notice
) do

  let(:admin) { FactoryGirl.create(:user, role: "admin") }
  let(:another_admin) { FactoryGirl.create(:user, role: "admin") }

  before do
    5.times { FactoryGirl.create(:user) }
  end

  scenario 'Admin demotes another admin' do
    login(admin)
    id = another_admin.id
    visit users_path
    find("#admin-#{id}", 'Remove Admin').click

    expect(page).to have_content("#{another_admin.username} is no longer an admin.")
    expect(User.find(id).role).to eq("member")
  end

  scenario 'User cannot demote an admin' do
    user = FactoryGirl.create(:user)
    login(user)

    expect { page.driver.submit :delete, admin_path(admin), {} }.
      to raise_error(ActionController::RoutingError)
  end
end
