class OrganizationAccount::SubscriptionsController < OrganizationAccount::BaseController
  before_action :set_organization

  def create
    @subscription_plan = SubscriptionPlan.find(subscription_params[:subscription_plan_id])
    @organization.subscribe_to_plan(@subscription_plan)
    redirect_to edit_organization_account_organization_subscription_path(@organization), notice: "Subscription updated successfully"
  end

  def edit
    @subscription = @organization.current_subscription
    # @payment_method = @organization.current_payment_method
    @invoices = ["abc123", "xyz987", "xkcd345"]
    # @invoices = @organization.invoices

    @title = "Billing ~ #{@organization.name}"
  end

  def new
    @current_subscription = @organization.current_subscription
    @subscription = Subscription.new(
      subscriber: @organization,
      plan:       @current_subscription ? @current_subscription.plan : nil
    )
    @subscription_plans = SubscriptionPlan.organization.active

    @title = "Billing ~ Change Plan ~ #{@organization.name}"
  end

  def update
    @subscription = @organization.current_subscription

    if @subscription.update_attributes(subscription_params)
      redirect_to edit_organization_account_organization_subscription_path(@organization), notice: "Payment method updated successfully"
    else
      redirect_to edit_organization_account_organization_subscription_path(@organization), alert: "There was a problem updating the payment method"
    end
  end

private

  def subscription_params
    params.require(:subscription).permit(
      :subscription_plan_id,
      :payment_method_id,
      :payment_method_type
    )
  end

end
