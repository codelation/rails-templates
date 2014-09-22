class UserAccount::PaymentMethodsController < UserAccount::BaseController
  before_action :set_subscription

  def edit
    @stripe_card = StripeCard.new
    @stripe_card.subscriber = current_user
    @stripe_cards = current_user.stripe_cards

    @title = "Billing ~ Payment Method ~ #{current_user.display_name}"
  end

private

  def set_subscription
    @subscription = current_user.current_subscription
  end

end
