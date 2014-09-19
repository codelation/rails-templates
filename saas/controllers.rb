module Saas
  class Controllers

    def self.confirmations_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/confirmations_controller.rb")
    end

    def self.contact_messages_controller
      File.read("#{File.dirname(__FILE__)}/controllers/contact_messages_controller.rb")
    end

    def self.home_controller
      File.read("#{File.dirname(__FILE__)}/controllers/home_controller.rb")
    end

    def self.organization_account_base_controller
      File.read("#{File.dirname(__FILE__)}/controllers/organization_account/base_controller.rb")
    end

    def self.organization_account_organization_memberships_controller
      File.read("#{File.dirname(__FILE__)}/controllers/organization_account/organization_memberships_controller.rb")
    end

    def self.organization_account_organizations_controller
      File.read("#{File.dirname(__FILE__)}/controllers/organization_account/organizations_controller.rb")
    end

    def self.organization_account_subscriptions_controller
      File.read("#{File.dirname(__FILE__)}/controllers/organization_account/subscriptions_controller.rb")
    end

    def self.passwords_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/passwords_controller.rb")
    end

    def self.registrations_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/registrations_controller.rb")
    end

    def self.sessions_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/sessions_controller.rb")
    end

    def self.unlocks_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/unlocks_controller.rb")
    end

    def self.user_account_base_controller
      File.read("#{File.dirname(__FILE__)}/controllers/user_account/base_controller.rb")
    end

    def self.user_account_organization_memberships_controller
      File.read("#{File.dirname(__FILE__)}/controllers/user_account/organization_memberships_controller.rb")
    end

    def self.user_account_organizations_controller
      File.read("#{File.dirname(__FILE__)}/controllers/user_account/organizations_controller.rb")
    end

    def self.user_account_subscriptions_controller
      File.read("#{File.dirname(__FILE__)}/controllers/user_account/subscriptions_controller.rb")
    end

    def self.user_account_users_controller
      File.read("#{File.dirname(__FILE__)}/controllers/user_account/users_controller.rb")
    end

  end
end
