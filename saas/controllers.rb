module Saas
  class Controllers

    def self.admin_sessions_controller
      File.read("#{File.dirname(__FILE__)}/controllers/admin/sessions_controller.rb")
    end

    def self.authentication_confirmations_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/confirmations_controller.rb")
    end

    def self.authentication_invitations_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/invitations_controller.rb")
    end

    def self.authentication_omniauth_callbacks_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/omniauth_callbacks_controller.rb")
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

    def self.application_controller
      File.read("#{File.dirname(__FILE__)}/controllers/application_controller.rb")
    end

    def self.contact_messages_controller
      File.read("#{File.dirname(__FILE__)}/controllers/contact_messages_controller.rb")
    end

    def self.home_controller
      File.read("#{File.dirname(__FILE__)}/controllers/home_controller.rb")
    end

    def self.omni_auth_providers_controller
      File.read("#{File.dirname(__FILE__)}/controllers/omni_auth_providers_controller.rb")
    end

    def self.organizations_controller
      File.read("#{File.dirname(__FILE__)}/controllers/organizations_controller.rb")
    end

    def self.organization_memberships_controller
      File.read("#{File.dirname(__FILE__)}/controllers/organization_memberships_controller.rb")
    end

    def self.payment_methods_controller
      File.read("#{File.dirname(__FILE__)}/controllers/payment_methods_controller.rb")
    end

    def self.subscribers_controller
      File.read("#{File.dirname(__FILE__)}/controllers/subscribers_controller.rb")
    end

    def self.subscriptions_controller
      File.read("#{File.dirname(__FILE__)}/controllers/subscriptions_controller.rb")
    end

    def self.users_controller
      File.read("#{File.dirname(__FILE__)}/controllers/users_controller.rb")
    end

  end
end
