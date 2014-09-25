module Saas
  class Controllers

    def self.admin_sessions_controller
      File.read("#{File.dirname(__FILE__)}/controllers/admin/sessions_controller.rb")
    end

    def self.authentication_confirmations_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/confirmations_controller.rb")
    end

    def self.authentication_passwords_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/passwords_controller.rb")
    end

    def self.authentication_registrations_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/registrations_controller.rb")
    end

    def self.authentication_sessions_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/sessions_controller.rb")
    end

    def self.authentication_unlocks_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/unlocks_controller.rb")
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

    def self.organization_account_payment_methods_controller
      File.read("#{File.dirname(__FILE__)}/controllers/organization_account/payment_methods_controller.rb")
    end

    def self.organization_account_stripe_cards_controller
      File.read("#{File.dirname(__FILE__)}/controllers/organization_account/stripe_cards_controller.rb")
    end

    def self.organization_account_subscriptions_controller
      File.read("#{File.dirname(__FILE__)}/controllers/organization_account/subscriptions_controller.rb")
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

    def self.user_account_payment_methods_controller
      File.read("#{File.dirname(__FILE__)}/controllers/user_account/payment_methods_controller.rb")
    end

    def self.user_account_stripe_cards_controller
      File.read("#{File.dirname(__FILE__)}/controllers/user_account/stripe_cards_controller.rb")
    end

    def self.user_account_subscriptions_controller
      File.read("#{File.dirname(__FILE__)}/controllers/user_account/subscriptions_controller.rb")
    end

    def self.user_account_users_controller
      File.read("#{File.dirname(__FILE__)}/controllers/user_account/users_controller.rb")
    end

  end
end
