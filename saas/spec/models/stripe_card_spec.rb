require "rails_helper"

# ---------------------------------------------------------
# Private Methods
# ---------------------------------------------------------

describe StripeCard, "#update_stripe_customer" do
  before(:each) do
    stub_request(:post, "https://api.stripe.com/v1/customers").to_return(
      body: File.read(File.join(Rails.root, "spec/web_mock/stripe_customer.json"))
    )
    @stripe_card = create(:stripe_card)
  end

  it "should create a new Stripe customer and add the card" do
    expect(@stripe_card.stripe_customer_id).to eq("cus_4paKHGMWyPEkmv")
  end

  it "should assign the card to the same Stripe customer if the subscriber already has a card" do
    @second_card = create(:stripe_card)
    expect(@second_card.stripe_customer_id).to eq(@stripe_card.stripe_customer_id)
  end
end

describe StripeCard, "#update_current_subscription" do
  before(:each) do
    stub_request(:post, "https://api.stripe.com/v1/customers").to_return(
      body: File.read(File.join(Rails.root, "spec/web_mock/stripe_customer.json"))
    )
    stub_request(:get, "https://api.stripe.com/v1/customers/cus_4paKHGMWyPEkmv").to_return(
      body: File.read(File.join(Rails.root, "spec/web_mock/stripe_customer.json"))
    )
    stub_request(:post, "https://api.stripe.com/v1/customers/cus_4paKHGMWyPEkmv/cards").to_return(
      body: File.read(File.join(Rails.root, "spec/web_mock/stripe_card.json"))
    )
    @user = create(:user)
    @plan = create(:subscription_plan)
    @subscription = @user.subscribe_to_plan(@plan)
  end

  it "should set the payment method to the subscriber's current subscription" do
    @stripe_card = create(:stripe_card, subscriber: @user)
    expect(@user.current_subscription.payment_method).to eq(@stripe_card)
  end

  it "should not change the payment method to the subscriber's current subscription" do
    @payment_method = create(:stripe_card, subscriber: @user)
    @subscription.payment_method = @payment_method
    @stripe_card = create(:stripe_card, subscriber: @user)
    expect(@user.current_subscription.payment_method).to eq(@payment_method)
  end
end
