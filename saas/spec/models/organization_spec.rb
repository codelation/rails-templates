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

describe Organization, "#time" do

  it "should return a time object with the correct time zone" do
    organization = build(:organization)
    expect(organization.time.name).to eq(organization.time_zone)
  end

end
