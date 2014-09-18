require "rails_helper"

# ---------------------------------------------------------
# Instance Methods
# ---------------------------------------------------------

describe User, "#time" do

  it "should return a time object with the correct time zone" do
    @user = build(:user)
    expect(@user.time.name).to eq(@user.time_zone)
  end

end

# ---------------------------------------------------------
# Private Methods
# ---------------------------------------------------------

describe User, "#set_subscription_plan" do

  it "should set the subscription plan for the user after create" do
    @subscription_plan = create(:subscription_plan)
    @user = create(:user, subscription_plan_id: @subscription_plan.id)

    expect(@user.current_subscription.plan).to eq(@subscription_plan)
  end

  it "should create an organization if the subscription plan an organization account type" do
    @subscription_plan = create(:organization_subscription_plan)
    @user = create(:user, subscription_plan_id: @subscription_plan.id)

    expect(@user.current_subscription).to eq(nil)
    expect(@user.organizations.count).to eq(1)

    @organization_membership = @user.organization_memberships.first

    expect(@organization_membership.role.to_s).to eq("owner")
    expect(@organization_membership.organization.current_subscription.plan).to eq(@subscription_plan)
  end
end
