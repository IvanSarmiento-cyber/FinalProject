FactoryBot.define do
    factory :user do
      email { Faker::Internet.free_email }
      password { "password123" }
      password_confirmation { "password123" }
    end
  end
  