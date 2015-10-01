require 'rails_helper'

RSpec.describe Favorite, type: :model do

  context 'favorites' do
    let!(:favorite) do
      FactoryGirl.create(:favorite)
    end

    it { should belong_to(:tattoo) }
    it { should belong_to(:user) }

    it { should validate_presence_of(:tattoo) }
    it { should validate_presence_of(:user) }

    it "should have a user assigned to it" do
      expect(favorite.user).to be_instance_of(User)
    end

    it "should have a tattoo assigned to it" do
      expect(favorite.tattoo).to be_instance_of(Tattoo)
    end
  end
end
