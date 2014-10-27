class Charge < ActiveRecord::Base
  belongs_to :invoice, touch: true
  belongs_to :payment_method, polymorphic: true

  scope :chronological, -> { order(created_at: :asc) }

  after_create :attempt_payment

  enum status: {
    failed:     0,
    succeeded:  1
  }

private

  def attempt_payment
    if self.invoice.total > 0
      begin
        self.payment_method.charge(self.invoice.total)
        self.succeeded!
      rescue => e
        self.failed!
      end
    else
      self.succeeded!
    end
  end
end
