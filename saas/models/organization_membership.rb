class OrganizationMembership < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user

  scope :ordered_by_organization_name, -> { includes(:organization).order("organizations.name ASC") }
  scope :ordered_by_user_name,         -> { includes(:user).order("users.name ASC") }

  enum role: {
    member: 0,
    admin:  1,
    owner:  2
  }
end
