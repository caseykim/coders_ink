require 'rails_helper'

feature "User submits a tattoo of their own", %(
As a user
I want to submit a tattoo for review
So that I could get feedback from others

  Acceptance Criteria
  [x] I must be authenticated to post new tattoo
  [x] I must provide a name for the tattoo
  [x] I must provide supply a url for tattoo image
  [x] I may optionally add a description
  [x] I must see an error if I submit an incorrect form
  [x] I must be brought to the tattoo details page after submission
) do
  scenario 'unauthenticated user cannot post new tattoo' do
    visit new_tattoo_path

    expect(page).to have_content('need to sign in or sign up before continuing')
  end

  scenario 'visitor creates a tattoo' do
    user = FactoryGirl.create(:user)
    url = "https://pbs.twimg.com/media/BQMYIh2CMAAmGqp.jpg"
    login(user)
    visit tattoos_path
    click_link "Add A Tattoo"

    fill_in "Title", with: "Brand New Tattoo"
    fill_in "Description", with: "Hurt a lot!"
    fill_in "Image URL", with: url
    fill_in "Studio", with: "Lucky's"
    fill_in "Artist", with: "Jill Fink"

    click_button "Submit"

    expect(page).to have_css("img[src*='#{url}']")
    expect(page).to have_content('Brand New Tattoo')
    expect(page).to have_content('Hurt a lot!')
    expect(page).to have_content("Lucky's")
    expect(page).to have_content("Jill Fink")
  end

  scenario 'visitor submits a blank form' do
    user = FactoryGirl.create(:user)
    login(user)
    visit tattoos_path
    click_link "Add A Tattoo"
    click_button "Submit"
    errors = "Title can't be blank, Url can't be blank"

    expect(page).to have_content(errors)
  end
end
