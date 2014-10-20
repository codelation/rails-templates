class Invoice < ActiveRecord::Base
  belongs_to :subscriber, polymorphic: true
  has_many :line_items, dependent: :destroy
  has_many :charges,    dependent: :destroy

  after_touch :calculate_total

  monetize :total_cents

  validates :subscriber, presence: true

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

  # Calculates the new total for the invoice
  # @return [Boolean] true if saved
  def calculate_total
    self.total = self.line_items.map(&:total).reduce(&:+)
    self.save
  end
end
