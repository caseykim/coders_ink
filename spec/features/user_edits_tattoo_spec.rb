require 'rails_helper'

feature "user edits a tattoo posting", %(
  As an authenticated user
  I want to edit my tattoo posting
  So that I can correct information displayed

  Acceptance Criteria
  [x] I can only edit my own tattoo posting
  [x] I must be authenticated in order to make change
  [x] I must be able to change the title
  [x] I must be able to change the description
  [x] I must be able to change the tattoo image
  [x] I must see a confirmation and be redirected to the tattoo detail page
  [x] I must see an error if I complete the form incorrectly
  [x] I can optionally add or delete the description
) do

  let(:user) { FactoryGirl.create(:user_with_tattoos) }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario "user cannot edit other user's tattoo posting" do
    another_user = FactoryGirl.create(:user_with_tattoos)
    tattoo = another_user.tattoos.first
    visit tattoo_path(tattoo)
    click_link 'Edit Tattoo'

    expect(page).to have_content('no permission to edit')
  end

  scenario "user cannot edit other user's tattoo posting" do
    tattoo = user.tattoos.first
    click_link 'Sign Out'
    visit edit_tattoo_path(tattoo)

    expect(page).to have_content('need to sign in or sign up before continuing')
  end

  scenario 'user edits tattoo posting' do
    tattoo = user.tattoos.first
    visit edit_tattoo_path(tattoo)
    fill_in 'Title', with: "NEW tattoo"
    fill_in 'Description', with: "Mashed potatoes"
    fill_in 'Image URL', with: "https://pbs.twimg.com/media/BQMYIh2CMAAmGqp.jpg"
    click_button 'Submit'

    expect(page).to have_content("Tattoo successfully updated.")
    expect(page).to have_content("NEW tattoo")
    expect(page).to have_content("Mashed potatoes")
    expect(page).to have_xpath("//img[contains(@src,'BQMYIh2CMAAmGqp.jpg')]")
  end

  scenario 'user cannot submit an incomplete form' do
    tattoo = user.tattoos.first
    visit edit_tattoo_path(tattoo)
    fill_in 'Title', with: ""
    fill_in 'Image URL', with: ""
    fill_in 'Description', with: ""
    click_button 'Submit'

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Url can't be blank")
    expect(page).to_not have_content("Description can't be blank")
  end
end
