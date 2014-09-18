class LineItem < ActiveRecord::Base
  belongs_to :invoice, touch: true

  monetize :amount_cents

  # Returns the calculated total for the line item
  # @return [Money] amount x quantity
  def total
    self.amount * self.quantity
  end
end
