require 'rails_helper'

feature "user edits account settings", %(
  As a user
  I want to edit my account settings
  So that I can change my information

  Acceptance Criteria
  [x] I must be able to change my password
  [x] I must be able to change my username
  [x] I must be able to change my email
  [x] I must be able to change my avatar
  [x] I must see the link to account settings when I am signed in
  [x] I must not be able to change information unless authenticated
  [x] I must not be able to change other users' information
) do

  let(:user) { FactoryGirl.create(:user) }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'user changes password and email' do
    click_link 'Account Settings'
    expect(current_path).to eq edit_user_registration_path

    new_password = "boogeyman"
    new_email = "boogeyman@gmail.com"
    fill_in 'Password', with: new_password
    fill_in 'Password confirmation', with: new_password
    fill_in 'Email', with: new_email
    fill_in 'Current password', with: user.password
    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully.')
    expect(page).to have_content(new_email)

    click_link 'Sign Out'
    visit new_user_session_path
    fill_in 'Email', with: new_email
    fill_in 'Password', with: new_password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
  end

  scenario 'password and password confirmation have to match to update' do
    click_link 'Account Settings'
    expect(current_path).to eq edit_user_registration_path

    new_password = "boogeyman"
    fill_in 'Password', with: new_password
    fill_in 'Password confirmation', with: "boogeymmm"
    fill_in 'Current password', with: user.password
    click_button 'Update'

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario 'user changes username and avatar' do
    click_link 'Account Settings'
    expect(current_path).to eq edit_user_registration_path

    old_username = user.username
    new_username = 'trishboogeybogey'
    new_avatar = 'https://scontent.cdninstagram.com/hphotos-xpf1/t51.2885-15/s320x320/e15/928946_916321521769110_83206274_n.jpg'
    fill_in 'Username', with: new_username
    fill_in 'Avatar', with: new_avatar
    fill_in 'Current password', with: user.password
    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully.')
    expect(page).to_not have_content(old_username)
    expect(page).to have_content(new_username)
    expect(page).to have_content(new_avatar)
  end

  scenario 'user cannot access users#edit if not authenticated' do
    click_link 'Sign Out'
    visit edit_user_registration_path

    expect(page).to have_content('need to sign in or sign up before continuing')
  end

  scenario "user cannot edit other users' information" do
    other_password = "blurryblah"
    other_user = FactoryGirl.create(:user,
      password: other_password, password_confirmation: other_password)
    visit edit_user_registration_path
    fill_in 'Username', with: 'bubblyblob'
    fill_in 'Email', with: other_user.email
    fill_in 'Current password', with: other_user.password
    click_button 'Update'

    expect(page).to have_content('Email has already been taken')
    expect(page).to have_content('Current password is invalid')
  end

end
