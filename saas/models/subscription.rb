# Ties an organization to a SubscriptionPlan and contains the information about the
# current billing cycle, trial end time, whether it auto renews, etc.
class Subscription < ActiveRecord::Base
  # Relationships
  belongs_to :payment_method, polymorphic: true
  belongs_to :plan, class_name: "SubscriptionPlan", foreign_key: "subscription_plan_id"
  belongs_to :subscriber, polymorphic: true

  # Validations
  validates :plan,       presence: true
  validates :subscriber, presence: true

  # Callbacks
  before_save :build_from_plan

  # Scopes
  scope :current, -> { where("ended_at IS NULL OR ended_at > ?", Time.now) }
  scope :ended,   -> { where("ended_at IS NOT NULL AND ended_at <= ?", Time.now) }

  enum status: {
    trialing: 0,
    active:   1,
    past_due: 2,
    unpaid:   3,
    canceled: 4
  }

  # Returns whether or not the subscription is still in use.
  # @return [Boolean]
  def current?
    in_use = !self.unpaid?
    not_ended = self.ended_at.nil? || self.ended_at > Time.now

    in_use && not_ended
  end

  # The amount the subscriber should be credited if
  # they cancel the subscription right now. Nil is
  # returned if there is no credit given.
  # @return [Money]
  def current_period_credit
    return if self.trialing?
    return if self.plan.price == 0
    return if self.current_period_end < self.subscriber.time.now

    current_period_days = (self.current_period_end - self.current_period_start) / 1.day
    current_period_days_left = ((self.current_period_end - self.subscriber.time.now) / 1.day).round
    price_per_day = self.plan.price / current_period_days

    price_per_day * current_period_days_left
  end

private

  def build_from_plan
    return unless self.plan

    self.trial_ends_at        ||= self.subscriber.time.now + self.plan.trial_length
    self.current_period_start ||= self.subscriber.time.now
    self.current_period_end   ||= self.current_period_start + self.plan.interval_length
  end

end
