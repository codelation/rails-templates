module Saas
  class Controllers

    def self.home_controller
      File.read("#{File.dirname(__FILE__)}/controllers/home_controller.rb")
    end

  end
end
