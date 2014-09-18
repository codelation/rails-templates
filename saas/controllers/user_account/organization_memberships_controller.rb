class UserAccount::OrganizationMembershipsController < UserAccount::BaseController

  def index
    @organization_memberships = current_user.organization_memberships
  end

end
