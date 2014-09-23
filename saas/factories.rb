module Saas
  class Factories

    def self.charge_factory
      File.read("#{File.dirname(__FILE__)}/spec/factories/charge_factory.rb")
    end

    def self.invoice_factory
      File.read("#{File.dirname(__FILE__)}/spec/factories/invoice_factory.rb")
    end

    def self.line_item_factory
      File.read("#{File.dirname(__FILE__)}/spec/factories/line_item_factory.rb")
    end

    def self.organization_factory
      File.read("#{File.dirname(__FILE__)}/spec/factories/organization_factory.rb")
    end

    def self.organization_membership_factory
      File.read("#{File.dirname(__FILE__)}/spec/factories/organization_membership_factory.rb")
    end

    def self.organization_role_factory
      File.read("#{File.dirname(__FILE__)}/spec/factories/organization_role_factory.rb")
    end

    def self.stripe_card_factory
      File.read("#{File.dirname(__FILE__)}/spec/factories/stripe_card_factory.rb")
    end

    def self.subscription_factory
      File.read("#{File.dirname(__FILE__)}/spec/factories/subscription_factory.rb")
    end

    def self.subscription_plan_factory
      File.read("#{File.dirname(__FILE__)}/spec/factories/subscription_plan_factory.rb")
    end

    def self.user_factory
      File.read("#{File.dirname(__FILE__)}/spec/factories/user_factory.rb")
    end

  end
end
