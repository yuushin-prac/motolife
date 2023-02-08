FactoryBot.define do
  factory :article do
    title { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:20) }

    trait :article_with_users do
      after(:build) do |article|
        article.users << create(:user)
      end
    end

    trait :invalid do
      title                {''}
    end
  end

  factory :sample_article, class: Article do
    title { "ninja" }
    body { "cool" }

    trait :invalid do
      title                {''}
    end
  end

end