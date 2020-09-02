FactoryBot.define do
  factory :product do
    name { Faker::Name.unique.name }
    price { Faker::Number.number(3) }
  end
end