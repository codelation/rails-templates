require "rails_helper"

# ---------------------------------------------------------
# Instance Methods
# ---------------------------------------------------------

describe Subscription, "#current_period_credit" do

  before(:each) do
    @subscription = build(:subscription)
  end

  it "should return nil during trial period" do
    @subscription.status = :trialing
    expect(@subscription.current_period_credit).to eq(nil)
  end

  it "should return nil if the plan is free" do
    @subscription.plan = SubscriptionPlan.new(price: 0)
    expect(@subscription.current_period_credit).to eq(nil)
  end

  it "should return nil if the current period is over" do
    @subscription.current_period_end = Time.now - 1.day
    expect(@subscription.current_period_credit).to eq(nil)
  end

  it "should return a prorated credit amount for the rest of the billing period" do
    # Let's make the current period 20 days long and we're right in the middle of it
    @subscription.current_period_start = Time.now - 10.days
    @subscription.current_period_end = Time.now + 10.days

    # And make the plan $20/interval so the price is $1/day
    @subscription.plan.price = Money.new(2000, "USD") # $20.00

    # We should get half the money back as an account credit
    expect(@subscription.current_period_credit).to eq(Money.new(1000, "USD")) # $10.00
  end

end
