module Saas
  class Workers

    def self.omni_auth_token_refresh
      File.read("#{File.dirname(__FILE__)}/workers/omni_auth_token_refresh_worker.rb")
    end

    def self.subscription_update
      File.read("#{File.dirname(__FILE__)}/workers/subscription_update_worker.rb")
    end

  end
end
