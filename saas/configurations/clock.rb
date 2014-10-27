require "clockwork"
require "./config/boot"
require "./config/environment"

module Clockwork
  every(1.hour, "OmniAuthTokenRefreshWorker") do
    OmniAuthProvider.where.not(name: "facebook").pluck(:id) do |provider_id|
      OmniAuthTokenRefreshWorker.perform_async(provider_id)
    end
  end

  every(1.hour, "SubscriptionUpdateWorker") do
    Subscription.where("current_period_end <= ?", Time.now).pluck(:id) do |subscription_id|
      SubscriptionUpdateWorker.perform_async(subscription_id)
    end
  end
end
