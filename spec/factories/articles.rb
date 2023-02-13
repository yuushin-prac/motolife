FactoryBot.define do
  factory :article do
    title { "aaaaa" }
    content { Faker::Lorem.characters(number:60) }

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
    content { "cool" }

    trait :invalid do
      title                {''}
    end
  end

end