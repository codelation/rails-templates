module Saas
  class Controllers

    def self.confirmations_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/confirmations_controller.rb")
    end

    def self.home_controller
      File.read("#{File.dirname(__FILE__)}/controllers/home_controller.rb")
    end

    def self.passwords_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/passwords_controller.rb")
    end

    def self.registrations_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/registrations_controller.rb")
    end

    def self.sessions_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/sessions_controller.rb")
    end

    def self.unlocks_controller
      File.read("#{File.dirname(__FILE__)}/controllers/authentication/unlocks_controller.rb")
    end

  end
end
