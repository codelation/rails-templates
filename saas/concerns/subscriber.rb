module Subscriber
  extend ActiveSupport::Concern

  included do
    monetize :account_balance_cents
    has_many :omni_auth_providers, as: :subscriber
    has_many :stripe_cards,        as: :subscriber
    has_many :subscriptions,       as: :subscriber
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
    @new_subscription = Subscription.create(plan: subscription_plan)
    @old_subscription = self.current_subscription

    if @old_subscription
      return @old_subscription if @old_subscription.plan == @new_subscription.plan
      activate_new_subscription
      end_old_subscription
    else
      activate_new_subscription
    end

    self.subscriptions << @new_subscription

    @new_subscription
  end

private

  def activate_new_subscription
    if @old_subscription
      @new_subscription.payment_method = @old_subscription.payment_method

      if @old_subscription.plan.free?
        # If the previous subscription was free, base the trial period on the date the subscriber was created
        @new_subscription.trial_ends_at = self.created_at + @new_subscription.plan.trial_length
      else
        # If the previous subscription was in the trial period, continue the trial on the new subscription
        trial_length_diff = @new_subscription.plan.trial_length - @old_subscription.plan.trial_length
        @new_subscription.trial_ends_at = @old_subscription.trial_ends_at + trial_length_diff
      end
    else
      @new_subscription.trial_ends_at = Time.now + @new_subscription.plan.trial_length
    end

    if @new_subscription.trial_ends_at > Time.now
      @new_subscription.trialing!
    else
      @new_subscription.active!
    end
  end

  def change_subscription_plans
    activate_new_subscription
    end_old_subscription
  end

  def end_old_subscription
    if account_credit = @old_subscription.current_period_credit
      self.account_balance -= account_credit
      self.save
    end

    @old_subscription.ended_at = Time.now
    @old_subscription.canceled!
  end
end
