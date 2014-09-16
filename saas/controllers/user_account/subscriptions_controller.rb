class UserAccount::SubscriptionsController < UserAccount::BaseController

  def edit
    @subscription = current_user.current_subscription
    # @payment_method = current_user.current_payment_method
    @invoices = ["abc123", "xyz987", "xkcd345"]
    # @invoices = current_user.invoices

    @title = "Billing"
  end

  def new
    @title = "Billing ~ Change Plan"
    @subscription_plans = SubscriptionPlan.user
  end

end
