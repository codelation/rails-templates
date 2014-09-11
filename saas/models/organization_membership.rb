class OrganizationMembership < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user
  belongs_to :role, class_name: "OrganizationRole"
end
