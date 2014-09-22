class StripeCard < PaymentMethod
  self.table_name = "stripe_cards"

  # Validations
  validates_presence_of :stripe_token, on: :create
  validates_presence_of :subscriber

  # Callbacks
  before_create :update_stripe_customer

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
