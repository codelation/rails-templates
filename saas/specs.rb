module Saas
  class Specs < ::Specs

    def self.ability
      File.read("#{File.dirname(__FILE__)}/spec/models/ability_spec.rb")
    end

    def self.charge
      File.read("#{File.dirname(__FILE__)}/spec/models/charge_spec.rb")
    end

    def self.factories
      File.read("#{File.dirname(__FILE__)}/spec/support/factories_spec.rb")
    end

    def self.invoice
      File.read("#{File.dirname(__FILE__)}/spec/models/invoice_spec.rb")
    end

    def self.line_item
      File.read("#{File.dirname(__FILE__)}/spec/models/line_item_spec.rb")
    end

    def self.organization
      File.read("#{File.dirname(__FILE__)}/spec/models/organization_spec.rb")
    end

    def self.stripe_card
      File.read("#{File.dirname(__FILE__)}/spec/models/stripe_card_spec.rb")
    end

    def self.subscriber
      File.read("#{File.dirname(__FILE__)}/spec/models/subscriber_spec.rb")
    end

    def self.subscription_plan
      File.read("#{File.dirname(__FILE__)}/spec/models/subscription_plan_spec.rb")
    end

    def self.subscription
      File.read("#{File.dirname(__FILE__)}/spec/models/subscription_spec.rb")
    end

    def self.subscription_plans_helper
      File.read("#{File.dirname(__FILE__)}/spec/helpers/subscription_plans_helper_spec.rb")
    end

    def self.user
      File.read("#{File.dirname(__FILE__)}/spec/models/user_spec.rb")
    end

    def self.web_mock_stripe_card_charge_fail
      File.read("#{File.dirname(__FILE__)}/spec/web_mock/stripe_card_charge_fail.json")
    end

    def self.web_mock_stripe_card_charge
      File.read("#{File.dirname(__FILE__)}/spec/web_mock/stripe_card_charge.json")
    end

    def self.web_mock_stripe_card_delete
      File.read("#{File.dirname(__FILE__)}/spec/web_mock/stripe_card_delete.json")
    end

    def self.web_mock_stripe_card
      File.read("#{File.dirname(__FILE__)}/spec/web_mock/stripe_card.json")
    end

    def self.web_mock_stripe_customer
      File.read("#{File.dirname(__FILE__)}/spec/web_mock/stripe_customer.json")
    end

    def self.workers_subscription_update_worker
      File.read("#{File.dirname(__FILE__)}/spec/workers/subscription_update_worker_spec.rb")
    end

  end
end
