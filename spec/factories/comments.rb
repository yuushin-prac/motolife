FactoryBot.define do
  factory :comment do
    comment_content { Faker::Lorem.characters(number:60) }
    association :article
    association :user

    trait :invalid do
      comment_content        {''}
    end
  end

end