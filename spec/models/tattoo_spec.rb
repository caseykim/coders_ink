require 'rails_helper'

RSpec.describe Tattoo, type: :model do

  context 'tattoos' do
    let!(:tattoo) do
      FactoryGirl.create(:tattoo, title: 'Celtic Armband')
    end

    it { should belong_to(:user) }
    it { should have_many(:reviews) }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:user_id) }

    it { should validate_length_of(:title).is_at_most(20) }

    it "should have a user assigned to it" do
      expect(tattoo.user).to be_instance_of(User)
    end

    it "should have a title" do
      expect(tattoo.title).to eq("Celtic Armband")
    end

    it "should have a description" do
      expect(tattoo.description).to eq("Great")
    end

    it "should have a url" do
      url = "http://www.clipartbest.com/cliparts/4T9/xK9/4T9xK9eTE.jpeg"
      expect(tattoo.url).to eq(url)
    end

    it "should have a studio" do
      expect(tattoo.studio).to eq("Inflicting Ink")
    end

    it "should have a artist" do
      expect(tattoo.artist).to eq("Jeff Goyette")
    end
  end
end
