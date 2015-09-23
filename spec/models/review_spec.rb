require 'rails_helper'

RSpec.describe Review, type: :model do

  context 'reviews' do
    let!(:review) do
      FactoryGirl.create(:review)
    end

    it { should belong_to(:tattoo) }
    it { should belong_to(:user) }

    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:tattoo_id) }
    it { should validate_presence_of(:rating) }
    it { should validate_numericality_of(:rating) }
    it { should validate_inclusion_of(:rating).
      in_range(1..5).with_message("Must be 1 through 5") }


    it "should have a user assigned to it" do
      expect(review.user_id).to eq(1)
    end

    it "should have a rating" do
      expect(review.rating).to eq(4)
    end

    it "should have a body" do
      expect(review.body).to eq("Its great!")
    end

    it "should have a tattoo assigned to it" do
      expect(review.tattoo_id).to eq(1)
    end
  end
end
