FactoryBot.define do
  factory :article do
    body { Faker::Lorem.characters(number:20) }
    user
  end
end