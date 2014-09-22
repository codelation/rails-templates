class UserAccount::OrganizationMembershipsController < UserAccount::BaseController

  def index
    @organization_memberships = current_user.organization_memberships.ordered_by_organization_name
    @title = "Organizations ~ #{current_user.display_name}"
  end

end
