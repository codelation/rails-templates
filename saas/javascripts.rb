module Saas
  class Javascripts < ::Javascripts
    def self.appication_user_account_subscriptions_new
      File.read("#{File.dirname(__FILE__)}/javascripts/application/user_account/subscriptions/new.js")
    end

    def self.flash_messages
      File.read("#{File.dirname(__FILE__)}/javascripts/flash_messages.js")
    end

    def self.home
      File.read("#{File.dirname(__FILE__)}/javascripts/home.js")
    end
  end
end
