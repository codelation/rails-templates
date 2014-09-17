class UserAccount::OrganizationMembershipsController < UserAccount::BaseController

  def index
    @owned_organizations = current_user.owned_organizations
    @organization_memberships = current_user.organization_memberships
  end

end
