require 'faker'

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password = Faker::Internet.password
    password password
    password_confirmation password

    trait :admin do
      role "admin"
    end
  end
end