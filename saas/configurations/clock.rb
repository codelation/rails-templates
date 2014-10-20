require "clockwork"
require "./config/boot"
require "./config/environment"

module Clockwork
  every(1.hour, "OmniAuthTokenRefreshWorker") do
    OmniAuthProvider.where.not(name: "facebook").find_each do |provider|
      OmniAuthTokenRefreshWorker.perform_async(provider.id)
    end
  end

  every(1.hour, "SubscriptionUpdateWorker") do
    Subscription.where("current_period_end <= ?", Time.now).find_each do |subscription|
      SubscriptionUpdateWorker.perform_async(subscription.id)
    end
  end
end
