# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    association :subscriber, factory: :organization
    association :plan,       factory: :subscription_plan

    trial_ends_at        { Time.now - 30.days }
    current_period_start { Time.now }
    current_period_end   { Time.now + 1.month }
    cancel_at_period_end false
    status               :active
  end
end
