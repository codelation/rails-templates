# Ties an organization to a SubscriptionPlan and contains the information about the
# current billing cycle, trial end time, whether it auto renews, etc.
class Subscription < ActiveRecord::Base
  belongs_to :payment_method, polymorphic: true
  belongs_to :plan, class_name: "SubscriptionPlan", foreign_key: "subscription_plan_id"
  belongs_to :subscriber, polymorphic: true

  before_save :build_from_plan

  scope :current, -> { where("ended_at IS NULL OR ended_at > ?", Time.now) }
  scope :ended,   -> { where("ended_at IS NOT NULL AND ended_at <= ?", Time.now) }

  enum status: {
    trialing: 0,
    active:   1,
    past_due: 2,
    unpaid:   3,
    canceled: 4
  }

  # The amount the subscriber should be credited if
  # they cancel the subscription right now. Nil is
  # returned if there is no credit given.
  # @return [Money]
  def current_period_credit
    return if self.trialing?
    return if self.plan.price == 0
    return if self.current_period_end < Time.now

    current_period_days = (self.current_period_end - self.current_period_start) / 1.day
    current_period_days_left = (self.current_period_end - Time.now) / 1.day
    price_per_day = self.plan.price / current_period_days

    price_per_day * current_period_days_left
  end

private

  def build_from_plan
    return unless self.plan

    self.trial_ends_at        ||= Time.now + self.plan.trial_length
    self.current_period_start ||= Time.now
    self.current_period_end   ||= self.current_period_start + self.plan.interval_length
  end

end
