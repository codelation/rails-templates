class UserAccount::StripeCardsController < UserAccount::BaseController
  before_action :set_subscription

  def create
    @stripe_card = StripeCard.new(stripe_card_params)
    @stripe_card.subscriber = current_user

    if @stripe_card.save
      redirect_to edit_user_account_subscription_payment_method_path, notice: "Payment method created successfully"
    else
      redirect_to edit_user_account_subscription_payment_method_path, alert: "There was a problem saving the payment method"
    end
  end

  def destroy
    @stripe_card = StripeCard.find(params[:id])
    @stripe_card.destroy
    redirect_to edit_user_account_subscription_payment_method_path, notice: "Payment method deleted successfully"
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
