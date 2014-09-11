# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription_plan do
    name              "Paid Plan"
    active            true
    price             Money.new(1900, "USD") # $19.00 USD
    interval          :month
    interval_count    1
    trial_period_days 14
    reference_code    "single-user-monthly-09-2014"

    factory :yearly_subscription_plan do
      interval          :year
      price             Money.new(19000, "USD") # $190.00 USD
      trial_period_days 30
      reference_code    "single-user-yearly-09-2014"
    end
  end
end
