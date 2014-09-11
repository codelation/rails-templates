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

describe User, "#generate_owned_organization" do

  it "should create an organization for a user" do
    @user = build(:user)

    @user.send(:generate_owned_organization) # because this is a private method

    expect(@user.owned_organizations.first).to_not eq(nil)
  end

  it "should run after user create" do
    @user = create(:user)

    expect(@user.owned_organizations.first).to_not eq(nil)
  end

  context "if organization name is provided" do

    it "should set the organization's name" do
      @user = create(:user, :with_organization_name)

      expect(@user.owned_organizations.first.name).to eq("Super Awesome Organization Name, LLC.")
    end

  end

  context "if no organization name is provided" do

    it "should set the organization's name" do
      @user = create(:user)

      expect(@user.owned_organizations.first.name).to eq(@user.name)
    end

  end

end

describe User, "#subscribe_owned_organization_to_plan" do

  it "should set the plan of the user's owned organization" do
    @user = build(:user)
    @plan = create(:subscription_plan)
    @user.subscription_plan_id = @plan.id
    @user.save

    @organization = @user.owned_organizations.first
    expect(@organization.current_subscription.plan).to eq(@plan)
  end
end
