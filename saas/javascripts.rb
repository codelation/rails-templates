module Saas
  class Javascripts < ::Javascripts
    def self.home
      File.read("#{File.dirname(__FILE__)}/javascripts/home.js")
    end
  end
end
