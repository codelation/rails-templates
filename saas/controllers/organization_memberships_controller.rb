class OrganizationMembershipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @organization_memberships = current_user.organization_memberships
  end

end
