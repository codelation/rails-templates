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

    def self.devise_invitations_edit
      File.read("#{File.dirname(__FILE__)}/views/devise/invitations/edit.html.erb")
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

    def self.layouts_home_footer
      File.read("#{File.dirname(__FILE__)}/views/layouts/home/_footer.html.erb")
    end

    def self.layouts_home_header
      File.read("#{File.dirname(__FILE__)}/views/layouts/home/_header.html.erb")
    end

    def self.layouts_home
      File.read("#{File.dirname(__FILE__)}/views/layouts/home.html.erb")
    end

    def self.omni_auth_providers_omni_auth_provider
      File.read("#{File.dirname(__FILE__)}/views/omni_auth_providers/_omni_auth_provider.html.erb")
    end

    def self.omni_auth_providers_codeship
      File.read("#{File.dirname(__FILE__)}/views/omni_auth_providers/codeship.html.erb")
    end

    def self.omni_auth_providers_dnsimple
      File.read("#{File.dirname(__FILE__)}/views/omni_auth_providers/dnsimple.html.erb")
    end

    def self.omni_auth_providers_index
      File.read("#{File.dirname(__FILE__)}/views/omni_auth_providers/index.html.erb")
    end

    def self.organization_memberships_edit
      File.read("#{File.dirname(__FILE__)}/views/organization_memberships/edit.html.erb")
    end

    def self.organization_memberships_index
      File.read("#{File.dirname(__FILE__)}/views/organization_memberships/index.html.erb")
    end

    def self.organization_memberships_new
      File.read("#{File.dirname(__FILE__)}/views/organization_memberships/new.html.erb")
    end

    def self.organizations_sidebar
      File.read("#{File.dirname(__FILE__)}/views/organizations/_sidebar.html.erb")
    end

    def self.organizations_edit
      File.read("#{File.dirname(__FILE__)}/views/organizations/edit.html.erb")
    end

    def self.organizations_index
      File.read("#{File.dirname(__FILE__)}/views/organizations/index.html.erb")
    end

    def self.organizations_new
      File.read("#{File.dirname(__FILE__)}/views/organizations/new.html.erb")
    end

    def self.payment_methods_edit
      File.read("#{File.dirname(__FILE__)}/views/payment_methods/edit.html.erb")
    end

    def self.subscription_plans_subscription_plan
      File.read("#{File.dirname(__FILE__)}/views/subscription_plans/_subscription_plan.html.erb")
    end

    def self.subscriptions_edit
      File.read("#{File.dirname(__FILE__)}/views/subscriptions/edit.html.erb")
    end

    def self.subscriptions_new
      File.read("#{File.dirname(__FILE__)}/views/subscriptions/new.html.erb")
    end

    def self.users_sidebar
      File.read("#{File.dirname(__FILE__)}/views/users/_sidebar.html.erb")
    end

    def self.users_edit
      File.read("#{File.dirname(__FILE__)}/views/users/edit.html.erb")
    end

  end
end
