require "rails_helper"

# ---------------------------------------------------------
# Instance Methods
# ---------------------------------------------------------

describe Organization, "#time" do

  it "should return a time object with the correct time zone" do
    organization = build(:organization)
    expect(organization.time.name).to eq(organization.time_zone)
  end

end
