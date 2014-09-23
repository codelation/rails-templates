module Saas
  class Models

    def self.ability
      File.read("#{File.dirname(__FILE__)}/models/ability.rb")
    end

    def self.admin_user
      File.read("#{File.dirname(__FILE__)}/models/admin_user.rb")
    end

    def self.charge
      File.read("#{File.dirname(__FILE__)}/models/charge.rb")
    end

    def self.contact_message
      File.read("#{File.dirname(__FILE__)}/models/contact_message.rb")
    end

    def self.invoice
      File.read("#{File.dirname(__FILE__)}/models/invoice.rb")
    end

    def self.line_item
      File.read("#{File.dirname(__FILE__)}/models/line_item.rb")
    end

    def self.organization_membership
      File.read("#{File.dirname(__FILE__)}/models/organization_membership.rb")
    end

    def self.organization_role
      File.read("#{File.dirname(__FILE__)}/models/organization_role.rb")
    end

    def self.organization
      File.read("#{File.dirname(__FILE__)}/models/organization.rb")
    end

    def self.payment_method
      File.read("#{File.dirname(__FILE__)}/models/payment_method.rb")
    end

    def self.stripe_card
      File.read("#{File.dirname(__FILE__)}/models/stripe_card.rb")
    end

    def self.subscription
      File.read("#{File.dirname(__FILE__)}/models/subscription.rb")
    end

    def self.subscription_plan
      File.read("#{File.dirname(__FILE__)}/models/subscription_plan.rb")
    end

    def self.user
      File.read("#{File.dirname(__FILE__)}/models/user.rb")
    end

  end
end
