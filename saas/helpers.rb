module Saas
  class Helpers < ::Helpers

    def self.subscription_plans
      File.read("#{File.dirname(__FILE__)}/helpers/subscription_plans_helper.rb")
    end

  end
end
