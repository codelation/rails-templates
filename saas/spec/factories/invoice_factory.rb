# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invoice do
    due_at "2014-09-17 13:10:15"
    period_start "2014-09-17 13:10:15"
    period_end "2014-09-17 13:10:15"
  end
end
