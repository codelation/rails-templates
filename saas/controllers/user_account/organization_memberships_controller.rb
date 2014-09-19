class UserAccount::OrganizationMembershipsController < UserAccount::BaseController

  def index
    @organization_memberships = current_user.organization_memberships
    @title = "Organizations ~ #{current_user.display_name}"
  end

end
