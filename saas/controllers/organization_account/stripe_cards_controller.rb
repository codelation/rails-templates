class OrganizationAccount::StripeCardsController < OrganizationAccount::BaseController
  before_action :set_subscription

  def create
    @stripe_card = StripeCard.new(stripe_card_params)
    @stripe_card.subscriber = @organization

    if @stripe_card.save
      redirect_to edit_organization_account_organization_subscription_payment_method_path(@organization), notice: "Payment method created successfully"
    else
      redirect_to edit_organization_account_organization_subscription_payment_method_path(@organization), alert: "There was a problem saving the payment method"
    end
  end

  def destroy
    @stripe_card = StripeCard.find(params[:id])
    @stripe_card.destroy
    redirect_to edit_organization_account_organization_subscription_payment_method_path(@organization), notice: "Payment method deleted successfully"
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
