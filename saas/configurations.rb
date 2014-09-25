module Saas
  class Configurations < ::Configurations

    def self.env
      return <<-ENV
DEVISE_SECRET_TOKEN=#{SecureRandom.hex(64)}
HOSTNAME=localhost:3000

STRIPE_PUBLISHABLE_KEY=SET_ME
STRIPE_SECRET_KEY=SET_ME_TOO
ENV
    end

    def self.gemfile(install_blocky, install_blogelator)
      return <<-GEMFILE
source "http://rubygems.org"

ruby "2.1.2"
gem "rails", "4.1.5"

gem "awesome_print"#{install_blocky ? "\ngem \"blocky\"" : ""}#{install_blogelator ? "\ngem \"blogelator\"" : ""}
gem "cancancan"
gem "coffee-rails"
gem "devise"
gem "ember-rails"
gem "ember-source"
gem "highline"
gem "jbuilder"
gem "jquery-rails"
gem "local_time"
gem "money-rails"
gem "omniauth"
gem "pg"
gem "puma"
gem "roadie"
gem "roadie-rails"
gem "sass-rails"
gem "sidekiq"
gem "stripe"
gem "uglifier"

group :development, :test do
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "foreman"
  gem "letter_opener_web"
  gem "quiet_assets"
  gem "rspec-rails"
  gem "spring"
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
  # Sales Site Routes
  root to: "home#index"
  %w(about contact features pricing privacy terms).each do |page|
    get page, to: "home#\#{page}", as: page
  end

  # Resource Routes
  namespace :organization_account do
    resources :organizations do
      resources :organization_memberships, path: "memberships"
      resources :stripe_cards,             path: "payment_methods"

      resource :subscription, path: "billing" do
        resource :payment_method
      end
    end
  end

  namespace :user_account do
    resources :organizations
    resources :organization_memberships, path: "memberships"
    resources :stripe_cards,             path: "payment_methods"
    resource  :user,                     path: "/"

    resource :subscription, path: "billing" do
      resource :payment_method
    end
  end
  resources :contact_messages

  # Authentication Routes
  devise_for :admin_users, controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, controllers: {
    confirmations: "authentication/confirmations",
    passwords:     "authentication/passwords",
    registrations: "authentication/registrations",
    sessions:      "authentication/sessions",
    unlocks:       "authentication/unlocks"
  }
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
