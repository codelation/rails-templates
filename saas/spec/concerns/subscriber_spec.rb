require "rails_helper"

describe Subscriber, "#active_subscription?" do

  before(:each) do
    @organization = create(:organization)
    @plan = create(:subscription_plan)
  end

  it "should return false if the subscriber has never had a subscription" do
    expect(@organization.active_subscription?).to eq(false)
  end

  it "should return true after adding a new subscription" do
    @subscription = @organization.subscribe_to_plan(@plan)
    expect(@organization.active_subscription?).to eq(true)
  end

  it "should return false when the current subscription is not active" do
    @subscription = @organization.subscribe_to_plan(@plan)
    @subscription.status = :past_due
    @subscription.save

    expect(@organization.active_subscription?).to eq(false)
  end

  it "should return false after the current subscription ends" do
    @subscription = @organization.subscribe_to_plan(@plan)
    @subscription.ended_at = Time.now - 1.day
    @subscription.save

    expect(@organization.active_subscription?).to eq(false)
  end
end

describe Subscriber, "#current_subscription" do

  before(:each) do
    @organization = create(:organization)
    @plan = create(:subscription_plan)
    @yearly_plan = create(:yearly_subscription_plan)
  end

  it "should return nil if the subscriber has never had a subscription" do
    expect(@organization.current_subscription).to eq(nil)
  end

  it "should return the first subscription that has not ended" do
    @subscription = @organization.subscribe_to_plan(@plan)
    expect(@organization.current_subscription).to eq(@subscription)

    @new_subscription = @organization.subscribe_to_plan(@yearly_plan)
    expect(@organization.current_subscription).to eq(@new_subscription)
  end

end

describe Subscriber, "#subscribe_to_plan(subscription_plan)" do

  before(:each) do
    @organization = create(:organization)
    @plan = create(:subscription_plan)
    @yearly_plan = create(:yearly_subscription_plan)
  end

  it "should return the created Subscription" do
    @subscription = @organization.subscribe_to_plan(@plan)
    expect(@subscription.class).to eq(Subscription)
  end

  it "should set the subscription plan on the Subscription" do
    @subscription = @organization.subscribe_to_plan(@plan)
    expect(@subscription.plan).to eq(@plan)
  end

  it "should set the current period start and end on the subscription" do
    @subscription = @organization.subscribe_to_plan(@plan)

    period_start = Time.now
    period_end = period_start + @plan.interval_length

    expect(@subscription.current_period_start).to be_within(10).of(period_start)
    expect(@subscription.current_period_end).to   be_within(10).of(period_end)
  end

  it "should set the trial end of the subscription based on the plan" do
    @subscription = @organization.subscribe_to_plan(@plan)

    trial_end = Time.now + @plan.trial_length
    expect(@subscription.trial_ends_at).to be_within(10).of(trial_end)

    @yearly_plan.trial_period_days = 0
    @subscription = @organization.subscribe_to_plan(@yearly_plan)

    expect(@subscription.trial_ends_at).to be_within(10).of(Time.now)
  end

  it "should end the current subscription if it exists" do
    @subscription = @organization.subscribe_to_plan(@plan)
    expect(@subscription.ended_at).to eq(nil)

    @new_subscription = @organization.subscribe_to_plan(@yearly_plan)
    @subscription.reload
    expect(@subscription.ended_at).to be_within(10).of(Time.now)
  end

  it "should not end or create a new subscription if subscribing to the same plan" do
    @subscription = @organization.subscribe_to_plan(@plan)

    expect(@organization.subscriptions.count).to      eq(1)
    expect(@organization.subscribe_to_plan(@plan)).to eq(@subscription)
    expect(@organization.subscriptions.count).to      eq(1)
  end

end
