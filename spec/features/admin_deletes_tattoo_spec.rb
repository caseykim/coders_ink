require 'rails_helper'

feature 'Admin deletes a tattoo posting', %(
  As an admin
  I want to delete a tattoo posting
  So that there is no inapproprite tattoo posting on our site

  Acceptance Criteria
  [x] I must see 'Delete' button for all tatto postings
  [x] I must be presented with success notice when tattoo deleted
  [x] I must be redirected to tattoo index page
) do
  let(:admin) { FactoryGirl.create(:user, role: "admin") }

  before do
    5.times { FactoryGirl.create(:user_with_tattoos) }
  end

  scenario "Admin sees 'Delete' buttons for every tattoo posting" do
    login(admin)
    visit tattoos_path

    Tattoo.all.each do |tattoo|
      expect(page).to have_css("#delete-#{tattoo.id}")
    end
  end

  scenario "Admin sees 'Delete' button in tattoo detail page" do
    login(admin)
    tattoo = Tattoo.first
    visit tattoo_path(tattoo)

    expect(page).to have_button('Delete')
    expect { click_on 'Delete' }.to change(Tattoo, :count).by(-1)
  end

  scenario "User does not see 'Delete' button on tattoo index page" do
    user = FactoryGirl.create(:user)
    login(user)

    Tattoo.all.each do |tattoo|
      expect(page).to_not have_css("#delete-#{tattoo.id}")
    end
  end

  scenario "Admin deletes a tattoo posting" do
    login(admin)
    visit tattoos_path
    tattoo = Tattoo.last

    expect { find("#delete-#{tattoo.id}", "Delete").click }.to change(Tattoo, :count).by(-1)
    expect(page).to have_content('Tattoo deleted successfully.')
    Tattoo.all.each do |tattoo|
      expect(page).to have_content(tattoo.title)
    end
  end
end
