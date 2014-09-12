module Saas
  class Seeds

    def self.admin_user_seeds
      File.read("#{File.dirname(__FILE__)}/seeds/admin_user_seeds.rb")
    end

    def self.seeds
      File.read("#{File.dirname(__FILE__)}/seeds/seeds.rb")
    end

    def self.subscription_plan_seeds
      File.read("#{File.dirname(__FILE__)}/seeds/subscription_plan_seeds.rb")
    end

  end
end
