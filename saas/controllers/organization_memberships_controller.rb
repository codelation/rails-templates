class OrganizationMembershipsController < ApplicationController

  def index
    @organization_memberships = @subscriber.memberships.ordered_by_organization_name
    @title = "Users ~ #{@subscriber.display_name}"
  end

  def new

  end

end
