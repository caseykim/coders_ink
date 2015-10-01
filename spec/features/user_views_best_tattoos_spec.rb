require 'rails_helper'

feature "User views the best tattoos", %(
  As a user
  I want to view the highest rated tattoos
  So I know what submissions are the most awesome

  Acceptance Criteria
  [x] I must see the title and rating of each tattoo posting
  [x] I must see only the 5 best tattoos
) do

  scenario 'visitor views best tattoos' do
    10.times { FactoryGirl.create(:tattoo_with_reviews) }

    t10 = Tattoo.find_by(title: "Celtic Armband 10")
    t9 = Tattoo.find_by(title: "Celtic Armband 9")
    t7 = Tattoo.find_by(title: "Celtic Armband 7")
    t6 = Tattoo.find_by(title: "Celtic Armband 6")
    t5 = Tattoo.find_by(title: "Celtic Armband 5")
    t1 = Tattoo.find_by(title: "Celtic Armband 1")
    Review.create(rating: 5, tattoo: t10, user: User.first)
    Review.create(rating: 5, tattoo: t9, user: User.first)
    Review.create(rating: 5, tattoo: t6, user: User.first)
    Review.create(rating: 5, tattoo: t5, user: User.first)
    Review.create(rating: 5, tattoo: t1, user: User.first)
    Review.create(rating: 1, tattoo: t7, user: User.first)

    visit best_tattoos_path
    expect(page).to have_content("Celtic Armband 10: #{t10.average_rating}")
    expect(page).to have_content("Celtic Armband 9: #{t9.average_rating}")
    expect(page).to have_content("Celtic Armband 6: #{t6.average_rating}")
    expect(page).to have_content("Celtic Armband 5: #{t5.average_rating}")
    expect(page).to have_content("Celtic Armband 1: #{t1.average_rating}")
    expect(page).to_not have_content("Celtic Armband 7: #{t7.average_rating}")
  end
end
