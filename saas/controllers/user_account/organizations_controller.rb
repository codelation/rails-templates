class UserAccount::OrganizationsController < UserAccount::BaseController

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      organization_membership = @organization.add_user(current_user)
      organization_membership.role = :owner
      organization_membership.save
      redirect_to edit_organization_account_organization_path(@organization), notice: "Organization created successfully"
    else
      @subscription_plans = SubscriptionPlan.organization.active
      @title = "New Organization ~ #{current_user.display_name}"
      @body_class = "#{@body_class} new"
      render :new
    end
  end

  def new
    @organization = Organization.new
    @subscription_plans = SubscriptionPlan.organization.active
    @title = "New Organization ~ #{current_user.display_name}"
  end

private

  def organization_params
    params.require(:organization).permit(:name, :subscription_plan_id)
  end

end
