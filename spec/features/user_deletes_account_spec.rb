require 'rails_helper'

feature 'user deletes account', %(
  As an authenticated user
  I want to delete my account
  So that my information is no longer retained by the app

  Acceptance Criteria
  [x] I must be able to delete my account from account settings
  [x] I must receive confirmation that my account has been cancelled
  [x] I must not be able to log in with my deleted account information
  [x] I must not be able to delete account unless authenticated
) do

  let(:user) { FactoryGirl.create(:user) }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'user deletes the account' do
    click_link 'Account Settings'
    click_button 'Cancel my account'

    expect(page).to have_content('account has been successfully cancelled.')
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Invalid email')
  end

  scenario 'user cannot access users#delete if not authenticated' do
    click_link 'Sign Out'
    visit edit_user_registration_path

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
