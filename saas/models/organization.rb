class Organization < ActiveRecord::Base
  include Subscriber

  # Relationships
  has_many :admin_invitations
  has_many :memberships, class_name: "OrganizationMembership"

  # Validations
  validates_presence_of :name

  # Add a user to the organization. Adding new users
  # does not give assign any roles/permissions.
  # @params [User] user
  # @return [OrganizationMembership]
  def add_user(user)
    # Check to see if the user has already been added
    membership = self.memberships.joins(:user).where(users: { id: user.id }).first
    return membership if membership

    membership = OrganizationMembership.create(
      organization: self,
      user:         user
    )

    self.memberships << membership
    self.reload # Make sure #users returns all users

    membership
  end

  # Returns a Time-like class with the
  # organization's selected time zone.
  # @return [ActiveSupport::TimeWithZone]
  def time
    Time.zone = self.time_zone
    Time.zone
  end
end
