module Saas
  class Javascripts < ::Javascripts
    def self.flash_messages
      File.read("#{File.dirname(__FILE__)}/javascripts/flash_messages.js")
    end

    def self.home
      File.read("#{File.dirname(__FILE__)}/javascripts/home.js")
    end
  end
end
