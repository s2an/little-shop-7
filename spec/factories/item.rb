FactoryBot.define do
  factory :item do
    association :merchant
    name { Faker::Commerce.product_name  }
    description { Faker::Lorem.paragraph }
    unit_price { Faker::Commerce.price(range: 0..10000.0) }
    status { "disabled" }
  end
end

#multiple factory/faker creations
#artists = create_list(:items, 10)