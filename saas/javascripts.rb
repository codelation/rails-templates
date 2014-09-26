module Saas
  class Javascripts < ::Javascripts
    def self.application_organizations_new
      File.read("#{File.dirname(__FILE__)}/javascripts/application/organizations/new.js")
    end

    def self.application_subscriptions_new
      File.read("#{File.dirname(__FILE__)}/javascripts/application/subscriptions/new.js")
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
