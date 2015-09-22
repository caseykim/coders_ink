require 'rails_helper'

feature "User submits a tattoo of their own", %(
As a user
I want to submit a tattoo for review
So that I could get feedback from others

  Acceptance Criteria
  [ ] I must provide a name for the tattoo
  [ ] I must provide supply a url for tattoo image
  [ ] I may optionally add a description
  [ ] I must see an error if I submit an incorrect form
  [ ] I must be brought to the tattoo details page after submission
) do

  scenario 'visitor creates a tattoo' do
    user = FactoryGirl.create(:user)
    login(user)

    visit tattoos_path

    click_link "Add A Tattoo"

    fill_in "Title", with: "Brand New Tattoo"
    fill_in "Description", with: "Hurt a lot!"
    fill_in "Image URL", with: "https://pbs.twimg.com/media/BQMYIh2CMAAmGqp.jpg"
    fill_in "Studio", with: "Lucky's"
    fill_in "Artist", with: "Jill Fink"

    click_button "Submit"

    urlcss = "img[src*='https://pbs.twimg.com/media/BQMYIh2CMAAmGqp.jpg']"
    expect(page).to have_content('Brand New Tattoo')
    expect(page).to have_content('Hurt a lot!')
    expect(page).to have_css(urlcss)
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

  scenario 'visitor submits a form while not signed in' do
    visit tattoos_path

    click_link "Add A Tattoo"

    fill_in "Title", with: "Brand New Tattoo"
    fill_in "Description", with: "Hurt a lot!"
    fill_in "Image URL", with: "https://pbs.twimg.com/media/BQMYIh2CMAAmGqp.jpg"

    click_button "Submit"

    expect(page).to have_content("User can't be blank")
  end
end
