module Saas
  class Views < ::Views

    def self.contact_message_mailer_contact_email
      File.read("#{File.dirname(__FILE__)}/views/contact_message_mailer/contact_email.html.erb")
    end

    def self.devise_registrations_new
      File.read("#{File.dirname(__FILE__)}/views/devise/registrations/new.html.erb")
    end

    def self.home
      File.read("#{File.dirname(__FILE__)}/views/layouts/home.html.erb")
    end

    def self.home_about
      File.read("#{File.dirname(__FILE__)}/views/home/about.html.erb")
    end

    def self.home_contact
      File.read("#{File.dirname(__FILE__)}/views/home/contact.html.erb")
    end

    def self.home_features
      File.read("#{File.dirname(__FILE__)}/views/home/features.html.erb")
    end

    def self.home_footer
      File.read("#{File.dirname(__FILE__)}/views/layouts/home/_footer.html.erb")
    end

    def self.home_header
      File.read("#{File.dirname(__FILE__)}/views/layouts/home/_header.html.erb")
    end

    def self.home_index
      File.read("#{File.dirname(__FILE__)}/views/home/index.html.erb")
    end

    def self.home_pricing
      File.read("#{File.dirname(__FILE__)}/views/home/pricing.html.erb")
    end

    def self.home_privacy
      File.read("#{File.dirname(__FILE__)}/views/home/privacy.html.erb")
    end

    def self.home_terms
      File.read("#{File.dirname(__FILE__)}/views/home/terms.html.erb")
    end

    def self.subscription_plans_subscription_plan
      File.read("#{File.dirname(__FILE__)}/views/subscription_plans/_subscription_plan.html.erb")
    end

  end
end
