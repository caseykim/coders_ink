require 'rails_helper'

feature "User views the best tattoos", %(
  As a user
  I want to view the highest rated tattoos
  So I know what submissions are the most awesome

  Acceptance Criteria
  [x] I must see the title and rating of each tattoo posting
  [x] I must see only the 6 best tattoos
) do

  scenario 'visitor views best tattoos' do
    t1 = FactoryGirl.create(:tattoo_with_reviews)
    t2 = FactoryGirl.create(:tattoo_with_reviews)
    t3 = FactoryGirl.create(:tattoo_with_reviews)
    t4 = FactoryGirl.create(:tattoo_with_reviews)
    t5 = FactoryGirl.create(:tattoo_with_reviews)
    t6 = FactoryGirl.create(:tattoo)
    t7 = FactoryGirl.create(:tattoo_with_reviews)

    visit best_tattoos_path
    expect(page).to have_content("#{t1.title}: #{t1.average_rating}")
    expect(page).to have_content("#{t2.title}: #{t2.average_rating}")
    expect(page).to have_content("#{t3.title}: #{t3.average_rating}")
    expect(page).to have_content("#{t4.title}: #{t4.average_rating}")
    expect(page).to have_content("#{t5.title}: #{t5.average_rating}")
    expect(page).to have_content("#{t7.title}: #{t7.average_rating}")
    expect(page).to_not have_content("#{t6.title}: #{t6.average_rating}")
  end
end
