module Saas
  class Helpers < ::Helpers

    def self.subscription_plan
      File.read("#{File.dirname(__FILE__)}/helpers/subscription_plan_helper.rb")
    end

  end
end
