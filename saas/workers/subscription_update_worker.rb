class SubscriptionUpdateWorker
  include Sidekiq::Worker

  def perform(subscription_id)
    @subscription = Subscription.find_by_id(subscription_id)
    return unless @subscription

    generate_invoice
    update_subscription
  end

private

  def generate_invoice

  end

  def update_subscription

  end

end
