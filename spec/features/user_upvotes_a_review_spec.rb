require 'rails_helper'

feature "User upvotes a review", %(
As a user
I want to upvote a review
So that I can decide which reviews are useful

  Acceptance Criteria
  [√] I must visit the tattoo details page
  [√] I must find a link to upvote
  [√] I must be able to upvote a review
  [√] The score must update
) do

  scenario 'visitor upvotes a review', js: true do
    tattoo = FactoryGirl.create(:tattoo)
    user = FactoryGirl.create(:user, username: "stever")
    user2 = FactoryGirl.create(:user)
    review = FactoryGirl.create(:review, tattoo: tattoo, user: user)
    login(user2)

    visit tattoo_path(tattoo)

    score = review.score
    find(".upvote").click
    count = find(".score_#{review.id}").text

    expect(count).to have_content("#{score + 1}")
  end

  scenario 'visitor upvotes a review they previously downvoted', js: true do
    tattoo = FactoryGirl.create(:tattoo)
    user = FactoryGirl.create(:user, username: "stever")
    user2 = FactoryGirl.create(:user)
    review = FactoryGirl.create(:review, tattoo: tattoo, user: user)
    login(user2)
    Vote.create(user: user2, review: review, score: -1)

    visit tattoo_path(tattoo)

    score = review.score
    find(".upvote").click
    count = find(".score_#{review.id}").text

    expect(count).to have_content("#{score + 2}")
  end

  scenario 'visitor removes their upvote', js: true do
    tattoo = FactoryGirl.create(:tattoo)
    user = FactoryGirl.create(:user, username: "stever")
    user2 = FactoryGirl.create(:user)
    review = FactoryGirl.create(:review, tattoo: tattoo, user: user)
    login(user2)
    Vote.create(user: user2, review: review, score: 1)

    visit tattoo_path(tattoo)

    score = review.score
    find(".upvote").click
    count = find(".score_#{review.id}").text

    expect(count).to have_content("#{score - 1}")
  end
end
