class UserAccount::StripeCardsController < UserAccount::BaseController
  before_action :set_subscription

  def create
    @stripe_card = StripeCard.new(stripe_card_params)
    @stripe_card.subscriber = current_user

    if @stripe_card.save
      redirect_to user_account_stripe_cards_path, notice: "Payment method created successfully"
    else
      @title = "Billing ~ Payment Method ~ #{current_user.display_name}"
      render :new
    end
  end

  def index
    @stripe_card = StripeCard.new
    @stripe_card.subscriber = current_user
    @stripe_cards = current_user.stripe_cards
    @title = "Billing ~ Payment Method ~ #{current_user.display_name}"
  end

private

  def set_subscription
    @subscription = current_user.current_subscription
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
