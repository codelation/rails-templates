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

