require "rails_helper"

# ---------------------------------------------------------
# Instance Methods
# ---------------------------------------------------------

describe Organization, "#add_user(user)" do

  before(:each) do
    @organization = create(:organization)
    @user = create(:user)
  end

  it "returns the OrganizationMembership when it adds the user to the organization" do
    membership = @organization.add_user(@user)
    expect(membership.class).to eq(OrganizationMembership)
  end

  it "returns the existing OrganizationMembership if the user already belongs to the organization" do
    membership = @organization.add_user(@user)
    expect(@organization.add_user(@user)).to eq(membership)
  end

  it "creates the OrganizationMembership between the Organization and User" do
    expect(@organization.memberships.count).to      eq(0)
    expect(@user.organization_memberships.count).to eq(0)

    @organization.add_user(@user)

    expect(@organization.memberships.count).to      eq(1)
    expect(@user.organization_memberships.count).to eq(1)
  end

  it "does not create extra memberships if the relationship exists" do
    @organization.add_user(@user)
    @organization.add_user(@user)
    @organization.add_user(@user)

    expect(@organization.memberships.count).to      eq(1)
    expect(@user.organization_memberships.count).to eq(1)
  end

end

describe Organization, "#owner_memberships" do

  before(:each) do
    @organization = create(:organization)
  end

  it "should return memberships to the organization with the owner role" do
    expect(@organization.owner_memberships).to eq([])

    @bob = create(:user, name: "Bob")
    membership = @organization.add_user(@bob)
    membership.role = :owner
    membership.save

    @april = create(:user, name: "April")
    membership = @organization.add_user(@april)
    membership.role = :admin
    membership.save

    @suzy = create(:user, name: "Suzy")
    membership = @organization.add_user(@suzy)
    membership.role = :member
    membership.save

    expect(@organization.owner_memberships.map(&:user)).to     include(@bob)
    expect(@organization.owner_memberships.map(&:user)).to_not include(@april)
    expect(@organization.owner_memberships.map(&:user)).to_not include(@suzy)
  end

  it "should order the memberships by the user's name" do
    expect(@organization.owner_memberships).to eq([])

    @bob = create(:user, name: "Bob")
    membership = @organization.add_user(@bob)
    membership.role = :owner
    membership.save

    @april = create(:user, name: "April")
    membership = @organization.add_user(@april)
    membership.role = :owner
    membership.save

    @suzy = create(:user, name: "Suzy")
    membership = @organization.add_user(@suzy)
    membership.role = :owner
    membership.save

    expect(@organization.owner_memberships.map(&:user)).to eq([@april, @bob, @suzy])
  end

end

describe Organization, "#time" do

  it "should return a time object with the correct time zone" do
    organization = build(:organization)
    expect(organization.time.name).to eq(organization.time_zone)
  end

end

# ---------------------------------------------------------
# Private Methods
# ---------------------------------------------------------

describe Organization, "#create_initial_subscription" do
  it "should set the subscription plan for the organization after create" do
    @subscription_plan = create(:organization_subscription_plan)
    @organization = create(:organization, subscription_plan_id: @subscription_plan.id)

    expect(@organization.current_subscription.plan).to eq(@subscription_plan)
  end
end
