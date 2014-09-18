module Saas
  class Factories

    def self.charge_factory
      File.read("#{File.dirname(__FILE__)}/factories/charge_factory.rb")
    end

    def self.invoice_factory
      File.read("#{File.dirname(__FILE__)}/factories/invoice_factory.rb")
    end

    def self.line_item_factory
      File.read("#{File.dirname(__FILE__)}/factories/line_item_factory.rb")
    end

    def self.organization_factory
      File.read("#{File.dirname(__FILE__)}/factories/organization_factory.rb")
    end

    def self.organization_membership_factory
      File.read("#{File.dirname(__FILE__)}/factories/organization_membership_factory.rb")
    end

    def self.organization_role_factory
      File.read("#{File.dirname(__FILE__)}/factories/organization_role_factory.rb")
    end

    def self.subscription_factory
      File.read("#{File.dirname(__FILE__)}/factories/subscription_factory.rb")
    end

    def self.subscription_plan_factory
      File.read("#{File.dirname(__FILE__)}/factories/subscription_plan_factory.rb")
    end

    def self.user_factory
      File.read("#{File.dirname(__FILE__)}/factories/user_factory.rb")
    end

  end
end
