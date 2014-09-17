class UserAccount::SubscriptionsController < UserAccount::BaseController

  def edit
    @subscription = current_user.current_subscription
    # @payment_method = current_user.current_payment_method
    @invoices = ["abc123", "xyz987", "xkcd345"]
    # @invoices = current_user.invoices

    @title = "Billing"
  end

  def new
    @current_subscription = current_user.current_subscription
    @subscription = Subscription.new(
      subscriber: current_user,
      plan:       @current_subscription ? @current_subscription.plan : nil
    )
    @subscription_plans = SubscriptionPlan.user

    @title = "Billing ~ Change Plan"
  end

end
