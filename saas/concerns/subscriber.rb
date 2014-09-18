module Subscriber
  extend ActiveSupport::Concern

  included do
    has_many :subscriptions, as: :subscriber
    monetize :account_balance_cents
  end

  # Returns whether or not the subscriber has an active subscription.
  # @return [Boolean]
  def active_subscription?
    if self.current_subscription && (self.current_subscription.active? || self.current_subscription.trialing?)
      true
    else
      false
    end
  end

  # The current subscription for the subscriber.
  # @return [Subscription]
  def current_subscription
    self.subscriptions.current.first
  end

  # Subscribe the user or organization to a new subscription plan.
  # A new subscription will be created. The old subscription will
  # be ended if there was an active subscription.
  # @param subscription_plan [SubscriptionPlan]
  # @return [Subscription]
  def subscribe_to_plan(subscription_plan)
    old_subscription = self.current_subscription

    if old_subscription
      return old_subscription if old_subscription.plan == subscription_plan
      end_subscription(old_subscription)
    end

    activate_subscription_plan(old_subscription, subscription_plan)
  end

private

  def activate_subscription_plan(old_subscription, subscription_plan)
    new_subscription = Subscription.create(plan: subscription_plan)

    if old_subscription && old_subscription.trialing? && subscription_plan.trial_length >= old_subscription.plan.trial_length
      trial_length_diff = subscription_plan.trial_length - old_subscription.plan.trial_length
      new_subscription.trial_ends_at = old_subscription.trial_ends_at + trial_length_diff
      new_subscription.trialing!
    elsif subscription_plan.trial_length > 0 && old_subscription.nil?
      new_subscription.trialing!
    else
      new_subscription.active!
    end

    self.subscriptions << new_subscription

    new_subscription
  end

  def end_subscription(subscription)
    subscription.ended_at = Time.now
    subscription.canceled!

    if account_credit = subscription.current_period_credit
      self.account_balance -= account_credit
      self.save
    end
  end
end
