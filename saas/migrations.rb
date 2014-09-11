module Saas
  class Migrations

    def self.create_admin_users
      File.read("#{File.dirname(__FILE__)}/migrations/create_admin_users.rb")
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
