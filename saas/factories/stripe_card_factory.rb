# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stripe_card do
    stripe_id "MyString"
    last4 "MyString"
    brand "MyString"
    exp_month 1
    exp_year 1
  end
end
