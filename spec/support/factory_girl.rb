require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_email#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    sequence(:username) { |n| "user#{n}" }
    profile_photo { Rack::Test::UploadedFile.new(File.join(
      Rails.root, '/spec/support/images/example.jpg')) }

    factory :user_with_tattoos do
      after(:create) do |user|
        5.times { create(:tattoo, user: user) }
      end
    end
  end

  factory :tattoo do
    sequence(:title) { |n| "Celtic Armband #{n}" }
    description "Great"
    url "http://www.clipartbest.com/cliparts/4T9/xK9/4T9xK9eTE.jpeg"
    user
    studio "Inflicting Ink"
    artist "Jeff Goyette"

    factory :tattoo_with_reviews do
      after(:create) do |tattoo|
        5.times { create(:review, tattoo: tattoo) }
      end
    end
  end

  factory :review do
    rating 4
    body "Its great!"
    user
    tattoo
  end

  factory :favorite do
    user
    tattoo
  end
end
