module Saas
  class Models

    def self.ability
      File.read("#{File.dirname(__FILE__)}/models/ability.rb")
    end

    def self.admin_user
      File.read("#{File.dirname(__FILE__)}/models/admin_user.rb")
    end

    def self.contact_message
      File.read("#{File.dirname(__FILE__)}/models/contact_message.rb")
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

    def self.organization_spec
      File.read("#{File.dirname(__FILE__)}/spec/models/organization_spec.rb")
    end

    def self.subscription
      File.read("#{File.dirname(__FILE__)}/models/subscription.rb")
    end

    def self.subscription_spec
      File.read("#{File.dirname(__FILE__)}/spec/models/subscription_spec.rb")
    end

    def self.subscription_plan
      File.read("#{File.dirname(__FILE__)}/models/subscription_plan.rb")
    end

    def self.subscription_plan_spec
      File.read("#{File.dirname(__FILE__)}/spec/models/subscription_plan_spec.rb")
    end

    def self.user
      File.read("#{File.dirname(__FILE__)}/models/user.rb")
    end

    def self.user_spec
      File.read("#{File.dirname(__FILE__)}/spec/models/user_spec.rb")
    end

  end
end
