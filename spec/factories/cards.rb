require 'faker'

FactoryGirl.define do
  factory :card do
    original_text Faker::Hipster.words
    translated_text Faker::Hipster.words
    interval 1
    repeat 1
    efactor 2.5
    quality 5
    attempt 1
    user
    block
  end
end
