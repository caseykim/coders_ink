require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :tattoo do
    sequence(:title) { |n| "Badass Celtic Armband Number #{n}" }
    description "Great"
    url "http://www.google.com"
    user_id 1
  end
end
