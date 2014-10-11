module Saas
  class Images

    def self.logo
      File.read("#{File.dirname(__FILE__)}/images/logo.png")
    end

    def self.omni_auth_providers_digitalocean
      File.read("#{File.dirname(__FILE__)}/images/omni_auth_providers/digitalocean.png")
    end

    def self.omni_auth_providers_facebook
      File.read("#{File.dirname(__FILE__)}/images/omni_auth_providers/facebook.png")
    end

    def self.omni_auth_providers_github
      File.read("#{File.dirname(__FILE__)}/images/omni_auth_providers/github.png")
    end

    def self.omni_auth_providers_google_oauth2
      File.read("#{File.dirname(__FILE__)}/images/omni_auth_providers/google_oauth2.png")
    end

    def self.omni_auth_providers_heroku
      File.read("#{File.dirname(__FILE__)}/images/omni_auth_providers/heroku.png")
    end

    def self.omni_auth_providers_twitter
      File.read("#{File.dirname(__FILE__)}/images/omni_auth_providers/twitter.png")
    end

  end
end
