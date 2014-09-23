# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :successful_charge, class: Charge do
    status :succeeded
  end

  factory :unsuccessful_charge, class: Charge do
    status :failed
  end
end
