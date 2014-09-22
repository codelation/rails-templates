class StripeCard < PaymentMethod
  self.table_name = "stripe_cards"

  # Validations
  validates_presence_of :stripe_token, on: :create
  validates_presence_of :subscriber

  # Callbacks
  before_create :update_stripe_customer

  def update_stripe_customer
    if last_stripe_card = self.subscriber.stripe_cards.last
      @stripe_customer = Stripe::Customer.retrieve(last_stripe_card.stripe_customer_id)
      @stripe_customer.cards.create(card: self.stripe_token)
    else
      @stripe_customer = Stripe::Customer.create(
        card:        self.stripe_token,
        description: self.subscriber.to_s,
        email:       self.subscriber.respond_to?(:email) ? self.subscriber.email : nil
      )
    end
    self.stripe_customer_id = @stripe_customer.id
  end
end
