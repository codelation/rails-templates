module Saas
  class Stylesheets < ::Stylesheets

    def self.application_layout_footer
      File.read("#{File.dirname(__FILE__)}/stylesheets/application/layout/_footer.scss")
    end

    def self.application_layout_header
      File.read("#{File.dirname(__FILE__)}/stylesheets/application/layout/_header.scss")
    end

    def self.application_layout_fonts
      File.read("#{File.dirname(__FILE__)}/stylesheets/application/layout/fonts.scss")
    end

    def self.application_layout_title
      File.read("#{File.dirname(__FILE__)}/stylesheets/application/layout/title.scss")
    end

    def self.application_organization_account_layout
      File.read("#{File.dirname(__FILE__)}/stylesheets/application/organization_account/layout.scss")
    end

    def self.application_organization_account_subscriptions_edit
      File.read("#{File.dirname(__FILE__)}/stylesheets/application/organization_account/subscriptions/edit.scss")
    end

    def self.application_organization_account_subscriptions_new
      File.read("#{File.dirname(__FILE__)}/stylesheets/application/organization_account/subscriptions/new.scss")
    end

    def self.application_user_account_layout
      File.read("#{File.dirname(__FILE__)}/stylesheets/application/user_account/layout.scss")
    end

    def self.application_user_account_organization_memberships_index
      File.read("#{File.dirname(__FILE__)}/stylesheets/application/user_account/organization_memberships/index.scss")
    end

    def self.application_user_account_organizations_new
      File.read("#{File.dirname(__FILE__)}/stylesheets/application/user_account/organizations/new.scss")
    end

    def self.application_user_account_stripe_cards_index
      File.read("#{File.dirname(__FILE__)}/stylesheets/application/user_account/stripe_cards/index.scss")
    end

    def self.application_user_account_subscriptions_edit
      File.read("#{File.dirname(__FILE__)}/stylesheets/application/user_account/subscriptions/edit.scss")
    end

    def self.application_user_account_subscriptions_new
      File.read("#{File.dirname(__FILE__)}/stylesheets/application/user_account/subscriptions/new.scss")
    end

    def self.contact_messages_main
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/contact_messages/main.scss")
    end

    def self.home(app_name)
      return <<-HOME
/*
 *= require #{app_name.underscore}/font-awesome
 *= require #{app_name.underscore}/normalize
 *= require_tree ./shared
 *= require_tree ./home
 *= require_self
 */
HOME
    end

    def self.home_features
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/home/features.scss")
    end

    def self.home_fonts
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/layout/fonts.scss")
    end

    def self.home_footer
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/layout/_footer.scss")
    end

    def self.home_header
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/layout/_header.scss")
    end

    def self.home_index
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/home/index.scss")
    end

    def self.home_index_header
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/home/index/header.scss")
    end

    def self.home_index_sign_up
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/home/index/sign_up.scss")
    end

    def self.home_pricing
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/home/pricing.scss")
    end

    def self.home_privacy
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/home/privacy.scss")
    end

    def self.home_terms
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/home/terms.scss")
    end

    def self.home_title
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/layout/title.scss")
    end

    def self.imports(app_name)
      return <<-IMPORTS
@import "#{app_name.underscore}/bourbon";
@import "variables";
@import "#{app_name.underscore}/neat";
@import "mixins/button";
@import "mixins/vertical_navigation";
IMPORTS
    end

    def self.mixins_vertical_navigation
      File.read("#{File.dirname(__FILE__)}/stylesheets/mixins/vertical_navigation.scss")
    end

    def self.shared_flash_messages
      File.read("#{File.dirname(__FILE__)}/stylesheets/shared/flash_messages.scss")
    end

    def self.shared_subscription_plan
      File.read("#{File.dirname(__FILE__)}/stylesheets/shared/subscription_plans/_subscription_plan.scss")
    end

    def self.shared_tables
      File.read("#{File.dirname(__FILE__)}/stylesheets/shared/tables.scss")
    end
  end
end
