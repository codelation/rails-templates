class OrganizationAccount::StripeCardsController < OrganizationAccount::BaseController
  before_action :set_subscription

  def create
    @stripe_card = StripeCard.new(stripe_card_params)
    @stripe_card.subscriber = @organization

    if @stripe_card.save
      redirect_to organization_account_organization_stripe_cards_path(@organization), notice: "Payment method created successfully"
    else
      @title = "Billing ~ Payment Method ~ #{@organization.name}"
      render :new
    end
  end

  def index
    @stripe_card = StripeCard.new
    @stripe_card.subscriber = @organization
    @stripe_cards = @organization.stripe_cards
    @title = "Billing ~ Payment Method ~ #{@organization.name}"
  end

private

  def set_subscription
    @subscription = @organization.current_subscription
  end

  def stripe_card_params
    params.require(:stripe_card).permit(
      :brand,
      :exp_month,
      :exp_year,
      :last4,
      :stripe_id,
      :stripe_token,
    )
  end

end
