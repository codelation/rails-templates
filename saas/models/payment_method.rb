class PaymentMethod < ActiveRecord::Base
  self.abstract_class = true
  belongs_to :subscriber, polymorphic: true
  has_many   :subscriptions
end
