# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    association :subscriber, factory: :organization
    association :plan,       factory: :subscription_plan

    trial_ends_at        "2014-09-08 15:56:07"
    current_period_start "2014-09-08 15:56:07"
    current_period_end   "2014-09-08 15:56:07"
    cancel_at_period_end false
    canceled_at          "2014-09-08 15:56:07"
    ended_at             "2014-09-08 15:56:07"
    status               1
  end
end
