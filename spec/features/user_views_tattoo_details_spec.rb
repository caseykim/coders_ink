require 'rails_helper'

feature "User views a specific tattoo", %(
  As a user
  I want to view a tattoo's details page
  So that I could read details and reviews on that tattoo

  Acceptance Criteria
  [X] I must visit the url of the tattoo.id
  [X] I must see the tattoo's title
  [X] I must see the tattoo's description, if one exists
  [X] I must see the picture of the tattoo that the url directs to
) do

  let!(:tattoo) do
    FactoryGirl.create(:tattoo, title: 'Dagron')
  end
  scenario 'visitor views tattoo details' do
    visit tattoo_path(tattoo)
    expect(page).to have_content('Dagron')
    expect(page).to have_content('Great')
    expect(page).to have_css("img[src*='#{tattoo.url}']")
    expect(page).to have_content('Inflicting Ink')
    expect(page).to have_content('Jeff Goyette')
  end
end
