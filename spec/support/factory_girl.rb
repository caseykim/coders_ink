require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    sequence(:username) { |n| "user#{n}" }

    factory :user_with_tattoos do
      after(:create) do |user|
        5.times { create(:tattoo, user: user) }
      end
    end
  end

  factory :tattoo do
    sequence(:title) { |n| "Badass Celtic Armband Number #{n}" }
    description "Great"
    url "http://www.google.com"
    user_id 1
  end
end
