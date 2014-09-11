require "rails_helper"

describe SubscriptionPlan, "#interval_length" do

  it "should return the length of the subscription" do
    @plan = build(:subscription_plan)
    expect(@plan.interval_length).to eq(1.month)

    @plan.interval_count = 6
    expect(@plan.interval_length).to eq(6.months)

    @plan.interval_count = 1
    @plan.interval = :year
    expect(@plan.interval_length).to eq(1.year)
  end

end

describe SubscriptionPlan, "#trial_length" do

  it "should return the length of the trial" do
    @plan = build(:subscription_plan)
    expect(@plan.trial_length).to eq(14.days)

    @plan = build(:yearly_subscription_plan)
    expect(@plan.trial_length).to eq(30.days)
  end

end
