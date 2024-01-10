FactoryBot.define do
  factory :merchant do
    name { Faker::Name.name  }
    status { "" }
  end
end