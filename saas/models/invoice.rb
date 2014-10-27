class Invoice < ActiveRecord::Base
  belongs_to :subscriber, polymorphic: true
  has_many :line_items, dependent: :destroy
  has_many :charges,    dependent: :destroy

  after_touch :calculate_total

  monetize :total_cents

  validates :subscriber, presence: true

  # Calculates the final amount and attempts to charge the subscriber.
  # @return [Boolean] whether or not the charge is successful
  def finalize!
    adjust_total unless self.finalized?

    charge = Charge.create(
      invoice:        self,
      payment_method: self.subscriber.current_subscription.payment_method
    )

    charge.succeeded?
  end

  # Returns whether or not the invoice has been finalized.
  # @return [Boolean]
  def finalized?
    self.charges.count > 0
  end

  # Returns the date for which the invoice was successfully paid
  # @return [Date] date of first successful charge, nil otherwise
  def paid_at
    return unless self.paid?
    self.charges.where(status: Charge.statuses[:succeeded]).chronological.first.created_at
  end

  # Returns if paid or not
  # @return [Boolean] true if there exists a successful charge
  def paid?
    self.charges.where(status: Charge.statuses[:succeeded]).count >= 1
  end

private

  # Adds an adjustment line item for adding/subtracting
  # the subscriber's account balance.
  def adjust_total
    calculate_total
    return if self.subscriber.account_balance == 0 || self.total == 0

    if self.subscriber.account_balance > 0
      self.line_items << LineItem.create(
        amount:      self.subscriber.account_balance,
        description: "Previous Account Balance"
      )
    else
      available_credit = -self.subscriber.account_balance

      if available_credit >= self.total
        credit_used = self.total
      else
        credit_used = available_credit
      end

      self.subscriber.account_balance += credit_used
      self.subscriber.save

      self.line_items << LineItem.create(
        amount:      -credit_used,
        description: "Pay with Account Credit"
      )
    end

    calculate_total
  end

  # Calculates the new total for the invoice
  # @return [Boolean] true if saved
  def calculate_total
    return unless self.line_items.count > 0
    self.total = self.line_items.map(&:total).reduce(&:+)
    self.save
  end
end
