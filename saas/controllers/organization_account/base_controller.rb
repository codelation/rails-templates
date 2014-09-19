class OrganizationAccount::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :set_body_class
  before_action :set_organization

private

  def set_body_class
    @body_class = "organization-account"
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
end
