require 'rails_helper'

RSpec.describe Tattoo, type: :model do

  context 'tattoos' do
    let!(:tattoo) do
      FactoryGirl.create(:tattoo, title: 'Badass Celtic Armband')
    end

    it "should have a user assigned to it" do
      expect(tattoo.user_id).to eq(1)
    end

    it "should have a title" do
      expect(tattoo.title).to eq("Badass Celtic Armband")
    end

    it "should have a description" do
      expect(tattoo.description).to eq("Great")
    end

    it "should have a url" do
      expect(tattoo.url).to eq("http://www.clipartbest.com/cliparts/4T9/xK9/4T9xK9eTE.jpeg")
    end
  end
end
