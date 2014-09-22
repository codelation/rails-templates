module Saas
  class Images

    def self.logo
      File.read("#{File.dirname(__FILE__)}/images/logo.png")
    end

  end
end
