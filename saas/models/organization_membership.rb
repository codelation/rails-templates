class OrganizationMembership < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user

  enum role: {
    member: 0,
    admin:  1,
    owner:  2
  }
end
