if SubscriptionPlan.count == 0

  # ------------------------------------------
  # Single User Plans
  # ------------------------------------------

  SubscriptionPlan.create(
    name:              "Free",
    active:            true,
    price:             Money.new(0, "USD"), # Free
    account_type:      :user,
    interval:          :month,
    interval_count:    1,
    trial_period_days: 0,
    reference_code:    "user-free-09-2014"
  )

  SubscriptionPlan.create(
    name:              "Value",
    active:            true,
    price:             Money.new(900, "USD"), # $9.00
    account_type:      :user,
    interval:          :month,
    interval_count:    1,
    trial_period_days: 30,
    reference_code:    "user-value-09-2014"
  )

  SubscriptionPlan.create(
    name:              "Pro",
    active:            true,
    price:             Money.new(5900, "USD"), # $59.00
    account_type:      :user,
    interval:          :month,
    interval_count:    1,
    trial_period_days: 30,
    reference_code:    "user-pro-09-2014"
  )

  # ------------------------------------------
  # Organization Plans
  # ------------------------------------------

  SubscriptionPlan.create(
    name:              "Small",
    active:            true,
    price:             Money.new(3900, "USD"), # $39.00
    account_type:      :organization,
    interval:          :month,
    interval_count:    1,
    trial_period_days: 30,
    reference_code:    "organization-small-09-2014"
  )

  SubscriptionPlan.create(
    name:              "Medium",
    active:            true,
    price:             Money.new(9900, "USD"), # $99.00
    account_type:      :organization,
    interval:          :month,
    interval_count:    1,
    trial_period_days: 30,
    reference_code:    "organization-medium-09-2014"
  )

  SubscriptionPlan.create(
    name:              "Large",
    active:            true,
    price:             Money.new(19900, "USD"), # $199.00
    account_type:      :organization,
    interval:          :month,
    interval_count:    1,
    trial_period_days: 30,
    reference_code:    "organization-large-09-2014"
  )

end
