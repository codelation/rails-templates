if SubscriptionPlan.count == 0

  SubscriptionPlan.create(
    name:              "Early Bird Plan",
    active:            true,
    price:             Money.new(1900, "USD"), # $19.00
    account_type:      :user,
    interval:          :month,
    interval_count:    1,
    trial_period_days: 30,
    reference_code:    "early-bird-user-09-2014"
  )

  SubscriptionPlan.create(
    name:              "Early Bird Plan",
    active:            true,
    price:             Money.new(4900, "USD"), # $49.00
    account_type:      :organization,
    interval:          :month,
    interval_count:    1,
    trial_period_days: 30,
    reference_code:    "early-bird-organization-09-2014"
  )

end
