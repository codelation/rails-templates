module Saas
  class Migrations

    def self.create_admin_users
      File.read("#{File.dirname(__FILE__)}/migrations/create_admin_users.rb")
    end

    def self.create_charges
      File.read("#{File.dirname(__FILE__)}/migrations/create_charges.rb")
    end

    def self.create_contact_messages
      File.read("#{File.dirname(__FILE__)}/migrations/create_contact_messages.rb")
    end

    def self.create_invoices
      File.read("#{File.dirname(__FILE__)}/migrations/create_invoices.rb")
    end

    def self.create_line_items
      File.read("#{File.dirname(__FILE__)}/migrations/create_line_items.rb")
    end

    def self.create_organization_memberships
      File.read("#{File.dirname(__FILE__)}/migrations/create_organization_memberships.rb")
    end

    def self.create_organization_roles
      File.read("#{File.dirname(__FILE__)}/migrations/create_organization_roles.rb")
    end

    def self.create_organizations
      File.read("#{File.dirname(__FILE__)}/migrations/create_organizations.rb")
    end

    def self.create_stripe_cards
      File.read("#{File.dirname(__FILE__)}/migrations/create_stripe_cards.rb")
    end

    def self.create_subscription_plans
      File.read("#{File.dirname(__FILE__)}/migrations/create_subscription_plans.rb")
    end

    def self.create_subscriptions
      File.read("#{File.dirname(__FILE__)}/migrations/create_subscriptions.rb")
    end

    def self.create_users
      File.read("#{File.dirname(__FILE__)}/migrations/create_users.rb")
    end

  end
end
