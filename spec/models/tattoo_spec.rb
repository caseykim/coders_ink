require 'rails_helper'

RSpec.describe Tattoo, type: :model do

  context 'tattoos' do
    let!(:tattoo) { FactoryGirl.create(:tattoo,
    title: 'Badass Celtic Armband') }

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
      expect(tattoo.url).to eq("http://www.google.com")
    end
  end
end
