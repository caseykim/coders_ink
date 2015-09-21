require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    sequence(:username) { |n| "user#{n}" }
  end

  factory :tattoo do
    sequence(:title) { |n| "Badass Celtic Armband Number #{n}" }
    description "Great"
    url "http://www.clipartbest.com/cliparts/4T9/xK9/4T9xK9eTE.jpeg"
    user_id 1
  end
end
