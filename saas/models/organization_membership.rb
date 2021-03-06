class OrganizationMembership < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user

  scope :ordered_by_organization_name, -> { joins(:organization).order("LOWER(organizations.name)") }
  scope :ordered_by_user_name,         -> { joins(:user).order("LOWER(users.name)") }

  enum role: {
    member: 0,
    admin:  1,
    owner:  2
  }
end
