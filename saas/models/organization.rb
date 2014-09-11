class Organization < ActiveRecord::Base
  include Subscriber

  belongs_to :owner, class_name: "User"
  has_many :admin_invitations

  # Returns a Time-like class with the
  # organization's selected time zone.
  # @return [ActiveSupport::TimeWithZone]
  def time
    Time.zone = self.time_zone
    Time.zone
  end
end
