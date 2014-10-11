module Saas
  class Configurations < ::Configurations

    def self.env
      return <<-ENV
DEVISE_SECRET_TOKEN=#{SecureRandom.hex(64)}
HOSTNAME=localhost:3000

STRIPE_PUBLISHABLE_KEY=SET_ME
STRIPE_SECRET_KEY=SET_ME

# OmniAuth Providers
DIGITAL_OCEAN_CLIENT_ID=SET_ME
DIGITAL_OCEAN_CLIENT_SECRET=SET_ME

FACEBOOK_CLIENT_ID=SET_ME
FACEBOOK_CLIENT_SECRET=SET_ME

GITHUB_CLIENT_ID=SET_ME
GITHUB_CLIENT_SECRET=SET_ME

GOOGLE_CLIENT_ID=SET_ME
GOOGLE_CLIENT_SECRET=SET_ME

HEROKU_CLIENT_ID=SET_ME
HEROKU_CLIENT_SECRET=SET_ME

TWITTER_CLIENT_ID=SET_ME
TWITTER_CLIENT_SECRET=SET_ME

ENV
    end

    def self.gemfile(install_blocky, install_blogelator)
      return <<-GEMFILE
source "http://rubygems.org"

ruby "2.2.0"
gem "rails", "~> 4.2.0.beta2"

gem "awesome_print"#{install_blocky ? "\ngem \"blocky\"" : ""}#{install_blogelator ? "\ngem \"blogelator\"" : ""}
gem "cancancan"
gem "coffee-rails"
gem "devise"
gem "ember-rails"
gem "ember-source"
gem "highline"
gem "jbuilder", "~> 2.0"
gem "jquery-rails", "~> 4.0.0.beta2"
gem "local_time"
gem "money-rails", github: "RubyMoney/money-rails"
gem "omniauth"
gem "omniauth-digitalocean"
gem "omniauth-facebook"
gem "omniauth-github"
gem "omniauth-google-oauth2"
gem "omniauth-heroku"
gem "omniauth-twitter"
gem "pg"
gem "puma"
gem "roadie"
gem "roadie-rails"
gem "sass-rails", "~> 5.0.0.beta1"
gem "sidekiq"
gem "stripe"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "foreman"
  gem "letter_opener_web"
  gem "quiet_assets"
  gem "rspec-rails"
  gem "spring"
  gem "web-console", "~> 2.0.0.beta4"
end

group :test do
  gem "capybara"
  gem "database_cleaner"
  gem "faker"
  gem "guard"
  gem "guard-rspec"
  gem "rb-fsevent"
  gem "terminal-notifier-guard"
  gem "webmock"
end
GEMFILE
    end

    def self.procfile
      File.read("#{File.dirname(__FILE__)}/configurations/Procfile")
    end

    def self.procfile_development
      File.read("#{File.dirname(__FILE__)}/configurations/Procfile.development")
    end

    def self.routes(app_class, install_blocky, install_blogelator)
      return <<-ROUTES
#{app_class}::Application.routes.draw do
  # Application Routes
  # These routes will be nested in both the organization and user
  # routes, so you'll be able access either type of subscription
  # with the routes of your application.
  def application_routes

  end

  # Sales Site Routes
  root to: "home#index"
  %w(about contact features pricing privacy terms).each do |page|
    get page, to: "home#\#{page}", as: page
  end
  resources :contact_messages



  # ---------------------------- DANGER ZONE ---------------------------- #

  # These routes handle user authentication and subscriptions.
  # Only edit these routes if you know what you're doing. Thanks!

  # Authentication Routes
  devise_for :admin_users, controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, controllers: {
    confirmations:      "authentication/confirmations",
    omniauth_callbacks: "authentication/omniauth_callbacks",
    passwords:          "authentication/passwords",
    registrations:      "authentication/registrations",
    sessions:           "authentication/sessions",
    unlocks:            "authentication/unlocks"
  }

  # Subscriber Routes
  # These routes handle the billing and organization memberships.
  resources :organizations, :users
  resource :subscriber, path: ":resource_name/:subscriber_id" do
    application_routes
    resources :omni_auth_providers
    resources :organization_memberships, path: "memberships"
    resources :payment_methods

    resource :subscription do
      resource :payment_method
    end
  end
#{install_blocky ? "\n  mount Blocky::Engine, at: \"/admin/content\"" : ""}#{install_blogelator ? "\n  mount Blogelator::Engine, at: \"/blog\"" : ""}
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/email"
  end
end
ROUTES
    end

    def self.stripe
      File.read("#{File.dirname(__FILE__)}/configurations/stripe.rb")
    end
  end
end
