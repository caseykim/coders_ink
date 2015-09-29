require 'rails_helper'

feature 'Admin deletes a review', %(
  As an admin
  I want to delete a review
  So that there is no inapproprite review on our site

  Acceptance Criteria
  [x] I must see 'Delete' button for all reviews
  [x] I must be presented with success notice when review is deleted
  [x] I must be redirected to tattoo details page
) do

  let(:admin) { FactoryGirl.create(:user, role: "admin") }

  before do
    5.times { FactoryGirl.create(:tattoo_with_reviews) }
  end

  scenario "Admin sees 'Delete' buttons for every review" do
    login(admin)

    Review.all.each do |review|
      visit tattoo_path(review.tattoo)
      expect(page).to have_css(".delete_review_#{review.id}")
    end
  end

  scenario "Admin deletes a review" do
    login(admin)
    review = Review.first
    tattoo = review.tattoo
    visit tattoo_path(tattoo)

    expect { find(".delete_review_#{review.id}").click }.to change(Review, :count).by(-1)
    expect(page).to have_content('Review deleted successfully.')
    expect(current_path).to eq tattoo_path(tattoo)
  end
end
