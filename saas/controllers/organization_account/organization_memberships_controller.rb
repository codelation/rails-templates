class OrganizationAccount::OrganizationMembershipsController < OrganizationAccount::BaseController

  def index
    @organization_memberships = @organization.memberships
    @title = "Users ~ #{@organization.name}"
  end

end
