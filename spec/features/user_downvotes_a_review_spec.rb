require 'rails_helper'
require 'selenium-webdriver'

feature "User downvotes a review", %(
As a user
I want to downvotes a review
So that I can decide which reviews are BAD

  Acceptance Criteria
  [√] I must visit the tattoo details page
  [√] I must find a link to downvote
  [√] I must be able to downvote a review
  [√] The score must update
) do

  scenario 'visitor downvotes a review', js: true do
    tattoo = FactoryGirl.create(:tattoo)
    user = FactoryGirl.create(:user, username: "stever")
    user2 = FactoryGirl.create(:user)
    review = FactoryGirl.create(:review, tattoo: tattoo, user: user)
    login(user2)

    visit tattoo_path(tattoo)

    score = review.score
    find(".downvote").click
    count = find(".score_#{review.id}").text

    expect(count).to have_content("#{score - 1}")
  end

  scenario 'visitor downvotes a review they previously upvoted', js: true do
    tattoo = FactoryGirl.create(:tattoo)
    user = FactoryGirl.create(:user, username: "stever")
    user2 = FactoryGirl.create(:user)
    review = FactoryGirl.create(:review, tattoo: tattoo, user: user)
    login(user2)
    Vote.create(user: user2, review: review, score: 1)

    visit tattoo_path(tattoo)

    score = review.score
    find(".downvote").click
    count = find(".score_#{review.id}").text

    expect(count).to have_content("#{score - 2}")
  end

  scenario 'visitor removes their downvote', js: true do
    tattoo = FactoryGirl.create(:tattoo)
    user = FactoryGirl.create(:user, username: "stever")
    user2 = FactoryGirl.create(:user)
    review = FactoryGirl.create(:review, tattoo: tattoo, user: user)
    login(user2)
    Vote.create(user: user2, review: review, score: -1)

    visit tattoo_path(tattoo)

    score = review.score
    find(".downvote").click
    count = find(".score_#{review.id}").text

    expect(count).to have_content("#{score + 1}")
  end
end
