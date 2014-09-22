class OrganizationAccount::PaymentMethodsController < OrganizationAccount::BaseController
  before_action :set_subscription

  def edit
    @stripe_card = StripeCard.new
    @stripe_card.subscriber = @organization
    @stripe_cards = @organization.stripe_cards

    @title = "Billing ~ Payment Method ~ #{@organization.name}"
  end

private

  def set_subscription
    @subscription = @organization.current_subscription
  end

end
