class OrganizationAccount::OrganizationsController < OrganizationAccount::BaseController
  def edit
    @title = "Profile ~ #{@organization.name}"
  end

  def show
    redirect_to edit_organization_account_organization_path(@organization)
  end

  def update
    if @organization.update_attributes(organization_params)
      redirect_to edit_organization_account_organization_path(@organization), notice: "Profile updated successfully"
    else
      @title = "Profile ~ #{@organization.name}"
      render :edit
    end
  end

private

  def organization_params
    params.require(:organization).permit(:name, :subscription_plan_id)
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end

end
