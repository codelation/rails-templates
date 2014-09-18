# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name      "Codelation"
    time_zone { Faker::Address.time_zone }
  end
end
