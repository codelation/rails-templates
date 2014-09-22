class OrganizationAccount::OrganizationMembershipsController < OrganizationAccount::BaseController

  def index
    @organization_memberships = @organization.memberships.ordered_by_user_name
    @title = "Users ~ #{@organization.name}"
  end

end
