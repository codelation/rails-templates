class StripeCard < PaymentMethod
  self.table_name = "stripe_cards"

  # Validations
  validates :stripe_token, presence: true, on: :create

  # Callbacks
  before_create  :update_stripe_customer
  after_create   :update_current_subscription
  before_destroy :delete_stripe_card

  # Charges the credit card through Stripe.
  # @param amount [Money]
  # @param description [String]
  # @return [Stripe::Charge]
  def charge(amount, description = nil)
    customer = Stripe::Customer.retrieve(self.stripe_customer_id)
    card = customer.cards.retrieve(self.stripe_card_id)

    Stripe::Charge.create(
      amount:      amount.fractional,
      currency:    amount.currency.iso_code,
      card:        card,
      description: description
    )
  end

  # The credit card brand with the last four digits for display purposes.
  # @return [String]
  def display_name
    "#{self.brand} ****#{self.last4}"
  end

  # The card's expiration month and year
  # with the format MM/YYYY.
  # @return [String]
  def expiration_date
    "#{sprintf('%02d', self.exp_month)} / #{self.exp_year}"
  end

private

  # Deletes the card from Stripe.
  def delete_stripe_card
    customer = Stripe::Customer.retrieve(self.stripe_customer_id)
    customer.cards.retrieve(self.stripe_card_id).delete
  end

  # Creates a new Stripe customer with the card added. It will be added
  # to the subscriber's existing Stripe customer if it exists.
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

  # Adds the card as the payment method on the subscriber's current
  # subscription if there isn't already a payment method set.
  def update_current_subscription
    subscription = self.subscriber.current_subscription

    if subscription && subscription.payment_method.nil?
      subscription.payment_method = self
      subscription.save
    end
  end
end
