module Saas
  class Configurations < ::Configurations

    def self.application(app_class)
      return <<-APPLICATION
require File.expand_path('../boot', __FILE__)

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module #{app_class}
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.assets.precompile += %w(
      #{app_class.underscore}/font-awesome/fontawesome-webfont.eot #{app_class.underscore}/font-awesome/fontawesome-webfont.svg
      #{app_class.underscore}/font-awesome/fontawesome-webfont.ttf #{app_class.underscore}/font-awesome/fontawesome-webfont.woff
      home.css home.js
    )

    # Sidekiq Configuration
    config.eager_load_paths += ["\#{config.root}/app/workers"]
    config.active_job.queue_adapter = :sidekiq
  end
end
APPLICATION
    end

    def self.clock
      File.read("#{File.dirname(__FILE__)}/configurations/clock.rb")
    end

    def self.devise_invitable
      File.read("#{File.dirname(__FILE__)}/configurations/locales/devise_invitable.en.yml")
    end

    def self.env
      return <<-ENV
DEVISE_SECRET_TOKEN=#{SecureRandom.hex(64)}
ENCRYPTION_TOKEN=#{SecureRandom.hex(64)}
HOSTNAME=localhost:3000

STRIPE_PUBLISHABLE_KEY=SET_ME
STRIPE_SECRET_KEY=SET_ME

# OmniAuth Providers
# Don't forget to remove any unused scope options

DIGITALOCEAN_CLIENT_ID=SET_ME
DIGITALOCEAN_CLIENT_SECRET=SET_ME
DIGITALOCEAN_SCOPE="read write"

FACEBOOK_CLIENT_ID=SET_ME
FACEBOOK_CLIENT_SECRET=SET_ME
FACEBOOK_SCOPE="email, public_profile, user_friends"

GITHUB_CLIENT_ID=SET_ME
GITHUB_CLIENT_SECRET=SET_ME
GITHUB_SCOPE="admin:public_key, admin:repo_hook, gist, repo, user"

GOOGLE_OAUTH2_CLIENT_ID=SET_ME
GOOGLE_OAUTH2_CLIENT_SECRET=SET_ME

HEROKU_CLIENT_ID=SET_ME
HEROKU_CLIENT_SECRET=SET_ME

SLACK_CLIENT_ID=SET_ME
SLACK_CLIENT_SECRET=SET_ME
SLACK_SCOPE="identify, post, read"

TWITTER_CLIENT_ID=SET_ME
TWITTER_CLIENT_SECRET=SET_ME
ENV
    end

    def self.gemfile(install_blocky, install_blogelator)
      return <<-GEMFILE
source "http://rubygems.org"

ruby "2.2.0"
gem "rails", github: "rails"

gem "awesome_print"#{install_blocky ? "\ngem \"blocky\"" : ""}#{install_blogelator ? "\ngem \"blogelator\"" : ""}
gem "cancancan"
gem "clockwork"
gem "coffee-rails"
gem "devise"
gem "devise_invitable"
gem "ember-rails"
gem "ember-source"
gem "gibberish"
gem "highline"
gem "jbuilder", "~> 2.0"
gem "jquery-rails", "~> 4.0.0.beta2"
gem "local_time"
gem "money-rails", github: "RubyMoney/money-rails"
gem "omniauth"
gem "pg"
gem "puma"
gem "rest-client"
gem "roadie"
gem "roadie-rails"
gem "sass-rails", "~> 5.0.0.beta1"
gem "sidekiq"
gem "sinatra"
gem "sshkey"
gem "stripe"
gem "uglifier", ">= 1.3.0"

# Connected Services - OmniAuth Providers
gem "omniauth-digitalocean"
gem "omniauth-facebook"
gem "omniauth-github"
gem "omniauth-google-oauth2"
gem "omniauth-heroku"
gem "omniauth-slack", github: "kmrshntr/omniauth-slack"
gem "omniauth-twitter"

# Connected Services - API Libraries
gem "barge"             # DigitalOcean
gem "fog"               # DNSimple
gem "koala"             # Facebook
gem "octokit"           # GitHub
gem "google-api-client" # Google
gem "platform-api"      # Heroku
gem "slack-api"         # Slack
gem "twitter"           # Twitter

group :development, :test do
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "foreman"
  gem "letter_opener_web"
  gem "quiet_assets"
  gem "rspec-rails"
  gem "spring"
  # gem "web-console", "~> 2.0.0.beta4"
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

  # Devise Routes for Admin Users
  devise_for :admin_users, controllers: {
    sessions: "admin/sessions"
  }

  # Pseudo OAuth Providers
  get "users/auth/:provider", to: "omni_auth_providers#new"

  # Devise Routes for Users
  devise_for :users, controllers: {
    confirmations:      "authentication/confirmations",
    invitations:        "authentication/invitations",
    omniauth_callbacks: "authentication/omniauth_callbacks",
    passwords:          "authentication/passwords",
    registrations:      "authentication/registrations",
    sessions:           "authentication/sessions",
    unlocks:            "authentication/unlocks"
  }

  #{install_blocky ? "\n  mount Blocky::Engine, at: \"/admin/content\"" : ""}#{install_blogelator ? "\n  mount Blogelator::Engine, at: \"/blog\"" : ""}
  # LetterOpener for Emails
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/email"
  end

  # Sidekiq Monitoring
  require "sidekiq/web"
  authenticate :admin_user do
    mount Sidekiq::Web => "/sidekiq"
  end

  # ------------------------------------------------------------------------- #
  # Routes should be above this line because of :resource_name/:subscriber_id

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
end
ROUTES
    end

    def self.stripe
      File.read("#{File.dirname(__FILE__)}/configurations/stripe.rb")
    end
  end
end
