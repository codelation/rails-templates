module Saas
  class Javascripts < ::Javascripts
    def self.account
      File.read("#{File.dirname(__FILE__)}/javascripts/account.js")
    end

    def self.account_organizations_new
      File.read("#{File.dirname(__FILE__)}/javascripts/account/organizations/new.js")
    end

    def self.account_subscriptions_new
      File.read("#{File.dirname(__FILE__)}/javascripts/account/subscriptions/new.js")
    end

    def self.flash_messages
      File.read("#{File.dirname(__FILE__)}/javascripts/flash_messages.js")
    end

    def self.home
      File.read("#{File.dirname(__FILE__)}/javascripts/home.js")
    end

    def self.vendor_moment
      File.read("#{File.dirname(__FILE__)}/javascripts/moment.js")
    end
  end
end
