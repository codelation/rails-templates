module Saas
  class Views < ::Views

    def self.admin_sessions_new
      File.read("#{File.dirname(__FILE__)}/views/admin/sessions/new.html.erb")
    end

    def self.contact_message_mailer_contact_email
      File.read("#{File.dirname(__FILE__)}/views/contact_message_mailer/contact_email.html.erb")
    end

    def self.contact_messages_new
      File.read("#{File.dirname(__FILE__)}/views/contact_messages/new.html.erb")
    end

    def self.contact_messages_show
      File.read("#{File.dirname(__FILE__)}/views/contact_messages/show.html.erb")
    end

    def self.current_users_edit
      File.read("#{File.dirname(__FILE__)}/views/current_users/edit.html.erb")
    end

    def self.devise_registrations_new
      File.read("#{File.dirname(__FILE__)}/views/devise/registrations/new.html.erb")
    end

    def self.home_about
      File.read("#{File.dirname(__FILE__)}/views/home/about.html.erb")
    end

    def self.home_features
      File.read("#{File.dirname(__FILE__)}/views/home/features.html.erb")
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

    def self.layouts_application_footer
      File.read("#{File.dirname(__FILE__)}/views/layouts/application/_footer.html.erb")
    end

    def self.layouts_application_header
      File.read("#{File.dirname(__FILE__)}/views/layouts/application/_header.html.erb")
    end

    def self.layouts_home
      File.read("#{File.dirname(__FILE__)}/views/layouts/home.html.erb")
    end

    def self.layouts_home_footer
      File.read("#{File.dirname(__FILE__)}/views/layouts/home/_footer.html.erb")
    end

    def self.layouts_home_header
      File.read("#{File.dirname(__FILE__)}/views/layouts/home/_header.html.erb")
    end

    def self.organization_account_organization_memberships_index
      File.read("#{File.dirname(__FILE__)}/views/organization_account/organization_memberships/index.html.erb")
    end

    def self.organization_account_organizations_edit
      File.read("#{File.dirname(__FILE__)}/views/organization_account/organizations/edit.html.erb")
    end

    def self.organization_account_payment_methods_edit
      File.read("#{File.dirname(__FILE__)}/views/organization_account/payment_methods/edit.html.erb")
    end

    def self.organization_account_subscriptions_edit
      File.read("#{File.dirname(__FILE__)}/views/organization_account/subscriptions/edit.html.erb")
    end

    def self.organization_account_subscriptions_new
      File.read("#{File.dirname(__FILE__)}/views/organization_account/subscriptions/new.html.erb")
    end

    def self.organization_account_sidebar
      File.read("#{File.dirname(__FILE__)}/views/organization_account/_sidebar.html.erb")
    end

    def self.subscription_plans_subscription_plan
      File.read("#{File.dirname(__FILE__)}/views/subscription_plans/_subscription_plan.html.erb")
    end

    def self.user_account_organization_memberships_index
      File.read("#{File.dirname(__FILE__)}/views/user_account/organization_memberships/index.html.erb")
    end

    def self.user_account_organizations_new
      File.read("#{File.dirname(__FILE__)}/views/user_account/organizations/new.html.erb")
    end

    def self.user_account_payment_methods_edit
      File.read("#{File.dirname(__FILE__)}/views/user_account/payment_methods/edit.html.erb")
    end

    def self.user_account_sidebar
      File.read("#{File.dirname(__FILE__)}/views/user_account/_sidebar.html.erb")
    end

    def self.user_account_subscriptions_edit
      File.read("#{File.dirname(__FILE__)}/views/user_account/subscriptions/edit.html.erb")
    end

    def self.user_account_subscriptions_new
      File.read("#{File.dirname(__FILE__)}/views/user_account/subscriptions/new.html.erb")
    end

    def self.user_account_users_edit
      File.read("#{File.dirname(__FILE__)}/views/user_account/users/edit.html.erb")
    end

  end
end
