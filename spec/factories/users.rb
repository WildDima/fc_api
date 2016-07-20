require 'faker'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.email }
    password '12345'
    password_confirmation '12345'
    locale 'ru'
    sequence(:authentication_token) { |n| SecureRandom.urlsafe_base64(nil, false) }
  end
end
