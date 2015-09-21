require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  # factory :fulluser do
  #   sequence(:email) {|n| "user#{n}@example.com" }
  #   encrypted_password 'password'
  #   sign_in_count 0
  #   created_at Time.now
  #   updated_at Time.now
  # end

  factory :tattoo do
    title "Badass Celtic Armband"
    description "Great"
    url "http://www.google.com"
    user_id 1
  end
end
