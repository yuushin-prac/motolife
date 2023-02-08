FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.free_email }
    password { "password" }
    password_confirmation { password }
    self_introduction { Faker::Lorem.characters(number: 30) }

    trait :user_with_articles do
      after(:build) do |user|
        user.articles << create(:article)
      end
    end

    trait :invalid do
      name                {''}
    end
  end

  factory :test_user, class: User do
    name { "testuser" }
    email { "testuser@example.com" }
    password { "password" }
    password_confirmation { password }
    self_introduction { "hello" }

    trait :invalid do
      name                {''}
    end
  end
end