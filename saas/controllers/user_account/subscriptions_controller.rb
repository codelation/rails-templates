class UserAccount::SubscriptionsController < UserAccount::BaseController

  def create
    @subscription_plan = SubscriptionPlan.find(subscription_params[:subscription_plan_id])
    current_user.subscribe_to_plan(@subscription_plan)
    redirect_to edit_user_account_subscription_path, notice: "Subscription updated successfully"
  end

  def edit
    @subscription = current_user.current_subscription
    # @payment_method = current_user.current_payment_method
    @invoices = ["abc123", "xyz987", "xkcd345"]
    # @invoices = current_user.invoices

    @title = "Billing ~ #{current_user.display_name}"
  end

  def new
    @current_subscription = current_user.current_subscription
    @subscription = Subscription.new(
      subscriber: current_user,
      plan:       @current_subscription ? @current_subscription.plan : nil
    )
    @subscription_plans = SubscriptionPlan.user.active

    @title = "Billing ~ Change Plan ~ #{current_user.display_name}"
  end

private

  def subscription_params
    params.require(:subscription).permit(:subscription_plan_id)
  end

end
