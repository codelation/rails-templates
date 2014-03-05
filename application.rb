# =================================================================
# Determine the app class name
# =================================================================

@app_class = @app_name.underscore.classify

if @app_name.end_with?("s") && !@app_class.end_with?("s")
  @app_class += "s"
end

# =================================================================
# Ask if Devise and CanCan should be installed
# =================================================================

install_devise = ask("Do you want to add authentication? [no]").downcase.start_with?("y")

# =================================================================
# Ask if Blogelator should be installed
# =================================================================

install_blogelator = ask("Do you want to add a blog? [no]").downcase.start_with?("y")

# =================================================================
# Files
# =================================================================

# -----------------------------------------
# app/assets/javascripts/application.js
# -----------------------------------------

run "rm app/assets/javascripts/application.js"
file "app/assets/javascripts/application/.keep", ""
file "app/assets/javascripts/application.js", <<-APPLICATIONJS
//= require jquery
//= require jquery_ujs
// require handlebars
// require ember
// require ember-data
//= require_tree ./application
APPLICATIONJS

# -----------------------------------------
# app/assets/stylesheets/_variables.scss
# -----------------------------------------

file "app/assets/stylesheets/_variables.scss", <<-VARIABLESSCSS
@import "bourbon";

// Typography
$sans-serif: $helvetica;
$serif: $georgia;

$base-font-family: $sans-serif;
$header-font-family: $base-font-family;

// Sizes
$base-font-size: 16px;
$base-line-height: $base-font-size * 1.5;
$base-border-radius: em(3);

// Body Color
$base-body-color: #fff;

// Font Colors
$base-font-color: #3e3e3e;
$base-accent-color: #df0061;

// Text Link Colors
$base-link-color: $base-accent-color;
$hover-link-color: darken($base-accent-color, 8%);

// Border color
$base-border-color: #ddd;

// Flash Colors
$error-color: #fbe3e4;
$notice-color: #fff6bf;
$success-color: #e6efc2;
VARIABLESSCSS

# -----------------------------------------
# app/assets/stylesheets/application/static_pages/home.scss
# -----------------------------------------

file "app/assets/stylesheets/application/static_pages/home.scss", <<-HOMESCSS
// Styles specific to StaticPagesController#home

@import "bourbon";
@import "variables";

body.static-pages.home {
  h1 {
    margin: 2em auto;
    text-align: center;
  }
}
HOMESCSS

# -----------------------------------------
# app/assets/stylesheets/application/static_pages.scss
# -----------------------------------------

file "app/assets/stylesheets/application/static_pages.scss", <<-STATICPAGESSCSS
// Styles shared by all StaticPagesController actions

@import "bourbon";
@import "variables";

body.static-pages {
  
}
STATICPAGESSCSS

# -----------------------------------------
# app/assets/stylesheets/shared/typography/body.scss
# -----------------------------------------

file "app/assets/stylesheets/shared/typography/body.scss", <<-BODYSCSS
@import "bourbon";
@import "variables";

p {
  margin: 0 0 ($base-line-height * .5);
}

a {
  color: $base-link-color;
  @include transition(color 0.1s linear);

  &:hover {
    color: $hover-link-color;
  }

  &:active, &:focus {
    color: $hover-link-color;
    outline: none;
  }
}

hr {
  border-bottom: 1px solid $base-border-color;
  border-left: none;
  border-right: none;
  border-top: none;
  margin: $base-line-height 0;
}

img {
  margin: 0;
  max-width: 100%;
}

abbr, acronym {
  border-bottom: 1px dotted $base-border-color;
  cursor: help;
}

address {
  display: block;
  margin: 0 0 ($base-line-height / 2);
}

hgroup {
  margin-bottom: $base-line-height / 2;
}

del {
  color: lighten($base-font-color, 15);
}

pre {
  font-family: "Menlo", "Monaco", monospace;
  margin: 0;
  padding: 0;
}

code {
  background-color: darken($base-body-color, 3%);
  border: 1px solid $base-border-color;
  border-radius: $base-border-radius;
  font-family: "Menlo", "Monaco", monospace;
  font-size: 0.95em;
  margin-left: 1px;
  margin-right: 1px;
  padding: 0 4px;
}

blockquote {
  border-left: 2px solid $base-border-color;
  color: lighten($base-font-color, 15);
  margin: $base-line-height 0;
  padding-left: $base-line-height / 2;
}

cite {
  color: lighten($base-font-color, 25);
  font-style: italic;

  &:before {
    content: '\\2014 \\00A0';
  }
}
BODYSCSS

# -----------------------------------------
# app/assets/stylesheets/shared/typography/forms.scss
# -----------------------------------------

file "app/assets/stylesheets/shared/typography/forms.scss", <<-FORMSSCSS
@import "bourbon";
@import "variables";

$form-border-color: $base-border-color;
$form-border-color-hover: darken($base-border-color, 10);
$form-border-color-focus: $base-accent-color;
$form-border-radius: $base-border-radius;
$form-box-shadow: inset 0 1px 3px hsla(0, 0%, 0%, 0.06);
$form-box-shadow-focus: $form-box-shadow, 0 0 5px rgba(darken($form-border-color-focus, 5), 0.7);
$form-font-size: $base-font-size;
$form-font-family: $base-font-family;

fieldset {
  background: lighten($base-border-color, 10);
  border: 1px solid $base-border-color;
  margin: 0 0 ($base-line-height / 2) 0;
  padding: $base-line-height;
}

input,
label,
select {
  display: block;
  font-family: $form-font-family;
  font-size: $form-font-size;
}

label {
  font-weight: bold;
  margin-bottom: $base-line-height / 4;

  &.required:after {
    content: "*";
  }

  abbr {
    display: none;
  }
}

textarea,
\#{$all-text-inputs} {
  @include box-sizing(border-box);
  @include transition(border-color);
  background-color: white;
  border-radius: $form-border-radius;
  border: 1px solid $form-border-color;
  box-shadow: $form-box-shadow;
  font-family: $form-font-family;
  font-size: $form-font-size;
  margin-bottom: $base-line-height / 2;
  padding: ($base-line-height / 3) ($base-line-height / 3);
  resize: vertical;
  width: 100%;

  &:hover {
    border-color: $form-border-color-hover;
  }

  &:focus {
    border-color: $form-border-color-focus;
    box-shadow: $form-box-shadow-focus;
    outline: none;
  }
}

input[type="search"] {
  @include appearance(none);
}

input[type="checkbox"], input[type="radio"] {
  display: inline;
  margin-right: $base-line-height / 4;
}

input[type="file"] {
  width: 100%;
}

select {
  width: auto;
  margin-bottom: $base-line-height;
}

button,
input[type="submit"] {
  @include appearance(none);
  cursor: pointer;
  user-select: none;
  vertical-align: middle;
  white-space: nowrap;
}
FORMSSCSS

# -----------------------------------------
# app/assets/stylesheets/shared/typography/headings.scss
# -----------------------------------------

file "app/assets/stylesheets/shared/typography/headings.scss", <<-HEADINGSSCSS
@import "bourbon";
@import "variables";

h1, h2, h3, h4, h5, h6 {
  font-family: $header-font-family;
  line-height: 1.25em;
  margin: 0 0 0.5em;
  text-rendering: optimizeLegibility; // Fix the character spacing for headings
}

h1 {
  font-size: $base-font-size * 2.25; // 16 * 2.25 = 36px
  margin-bottom: 1em;
}

h2 {
  font-size: $base-font-size * 2; // 16 * 2 = 32px
  margin-bottom: 0.7em;
}

h3 {
  font-size: $base-font-size * 1.75; // 16 * 1.75 = 28px
  margin-bottom: 0.5em;
}

h4 {
  font-size: $base-font-size * 1.5; // 16 * 1.5 = 24px
  margin-bottom: 0.25em;
}

h5 {
  font-size: $base-font-size * 1.25; // 16 * 1.25 = 20px
  margin-bottom: 0.25em;
}

h6 {
  font-size: $base-font-size;
  margin-bottom: 0.25em;
}
HEADINGSSCSS

# -----------------------------------------
# app/assets/stylesheets/shared/typography/lists.scss
# -----------------------------------------

file "app/assets/stylesheets/shared/typography/lists.scss", <<-LISTSSCSS
@import "bourbon";
@import "variables";

body.blogelator {
  ul, ol {
    margin: 0;
    padding: 0;
    margin-bottom: $base-line-height / 2;
    padding-left: $base-line-height;
  }

  dl {
    line-height: $base-line-height;
    margin-bottom: $base-line-height / 2;

    dt {
      font-weight: bold;
      margin-top: $base-line-height / 2;
    }

    dd {
      margin: 0;
    }
  }
}
LISTSSCSS

# -----------------------------------------
# app/assets/stylesheets/application.css.scss
# -----------------------------------------

run "rm app/assets/stylesheets/application.css"
file "app/assets/stylesheets/application.css.scss", <<-APPLICATIONCSS
/*
 *= require normalize
 *= require font-awesome
 *= require_tree ./shared
 *= require_tree ./application
 *= require_self
 */
APPLICATIONCSS

# -----------------------------------------
# app/controllers/static_pages_controller.rb
# -----------------------------------------

file "app/controllers/static_pages_controller.rb", <<-STATICPAGESCONTROLLER
class StaticPagesController < ApplicationController
  
  def home
    @title = "Welcome"
  end
  
end
STATICPAGESCONTROLLER

# -----------------------------------------
# app/helpers/application_helper.rb
# -----------------------------------------

run "rm app/helpers/application_helper.rb"
file "app/helpers/application_helper.rb", <<-APPLICATIONHELPER
module ApplicationHelper
  include LocalTimeHelper
  
  def body_class
    @body_class ||= "default"
    body_class = "blogelator"
    body_class += " " + controller.controller_name.dasherize
    body_class += " " + controller.action_name.dasherize
    body_class += " " + @body_class
    body_class
  end
  
  def page_title
    page = @title
    if page
      "\#{page} • \#{site_title}"
    else
      site_title
    end
  end
  
  def site_title
    "#{@app_name.titleize}"
  end
  
end
APPLICATIONHELPER

# -----------------------------------------
# app/views/layouts/_footer.html.erb
# -----------------------------------------

file "app/views/layouts/_footer.html.erb", <<-FOOTER
<footer>
</footer>
FOOTER

# -----------------------------------------
# app/views/layouts/_header.html.erb
# -----------------------------------------

file "app/views/layouts/_header.html.erb", <<-FOOTER
<header>
</header>
FOOTER

# -----------------------------------------
# app/views/layouts/application.html.erb
# -----------------------------------------

run "rm app/views/layouts/application.html.erb"
file "app/views/layouts/application.html.erb", <<-APPLICATIONLAYOUT
<!DOCTYPE html>
<html>
<head>
  <title><%= page_title %></title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <%= stylesheet_link_tag    "application" %>
  <%= javascript_include_tag "application" %>
  <%= csrf_meta_tags %>
</head>

<body class="<%= body_class %>">
  <%= render partial: "layouts/header" %>
  <main>
    <%= yield %>
  </main>
  <%= render partial: "layouts/footer" %>
</body>

</html>
APPLICATIONLAYOUT

# -----------------------------------------
# app/views/static_pages/home.html.erb
# -----------------------------------------

file "app/views/static_pages/home.html.erb", <<-HOMEERB
<div class="static-pages home">
  <h1>
    <i class="fa fa-github"></i>
    Welcome to #{@app_name.titleize}
  </h1>
</div>
HOMEERB

# -----------------------------------------
# config/environments/development.rb
# -----------------------------------------

run "rm config/environments/development.rb"
file "config/environments/development.rb", <<-DEVELOPMENT
#{@app_class}::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  
  # Use Letter Opener for sending email in development
  config.action_mailer.default_url_options = { :host => "localhost:3000" }
  config.action_mailer.asset_host = "http://localhost:3000"
  config.action_mailer.delivery_method = :letter_opener
  
  # Set Ember.js file to load
  config.ember.variant = :development
end
DEVELOPMENT

# -----------------------------------------
# config/environments/production.rb
# -----------------------------------------

run "rm config/environments/production.rb"
file "config/environments/production.rb", <<-PRODUCTION
#{@app_class}::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both thread web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_assets = false

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = "1.0"

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # config.assets.precompile += %w( search.js )

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false
  
  # Use SMTP for sending email in production
  config.action_mailer.default_url_options = { :host => ENV["HOSTNAME"] }
  config.action_mailer.asset_host = "http://\#{ENV["HOSTNAME"]}"
  config.action_mailer.delivery_method = :smtp

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new
  
  # Set Ember.js file to load
  config.ember.variant = :production
end
PRODUCTION

# -----------------------------------------
# config/initializers/secret_token.rb
# -----------------------------------------

run "rm config/initializers/secret_token.rb"
file "config/initializers/secret_token.rb", <<-SECRETTOKEN
# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
#{@app_class}::Application.config.secret_key_base = ENV["SECRET_TOKEN"]
SECRETTOKEN

# -----------------------------------------
# config/initializers/smtp.rb
# -----------------------------------------
file "config/initializers/smtp.rb", <<-SMTP
ActionMailer::Base.smtp_settings = {
  :address        => ENV["SMTP_ADDRESS"],
  :port           => ENV["SMTP_PORT"],
  :authentication => :plain,
  :user_name      => ENV["SMTP_USER_NAME"],
  :password       => ENV["SMTP_PASSWORD"],
  :domain         => ENV["HOSTNAME"]
}
ActionMailer::Base.delivery_method = :smtp
SMTP

# -----------------------------------------
# config/database.yml
# -----------------------------------------

run "rm config/database.yml"
file "config/database.yml", <<-DATABASE
development:
  adapter: postgresql
  database: #{@app_name.underscore}_development
  host: localhost
  
test:
  adapter: postgresql
  database: #{@app_name.underscore}_test
  host: localhost
  
production:
  adapter: postgresql
  database: #{@app_name.underscore}_production
  host: localhost
DATABASE

# -----------------------------------------
# config/jshint.json
# -----------------------------------------

file "config/jshint.json", <<-JSHINT
{
  "camelcase": true,
  "indent": 2,
  "white": false,
  "curly": true,
  "eqeqeq": true,
  "immed": true,
  "latedef": true,
  "newcap": true,
  "noarg": true,
  "sub": true,
  "undef": true,
  "boss": true,
  "eqnull": true,
  "browser": true,
  "predef": {
    "alert": true,
    "confirm": true,
    "console": true,
    "test": true,
    "equal": true,
    "ok": true,
    "sinon": true,
    "require": true,
    "$": true,
    "jQuery": true,
    "Ember": true,
    "Handlebars": true,
    "App": true
  }
}
JSHINT

# -----------------------------------------
# config/routes.rb
# -----------------------------------------

run "rm config/routes.rb"
file "config/routes.rb", <<-ROUTES
#{@app_class}::Application.routes.draw do
end
ROUTES

# -----------------------------------------
# lib/tasks/development.rake
# -----------------------------------------

file "lib/tasks/development.rake", <<-DEVELOPMENT
desc "Start the server in development mode"
task :start => :environment do
  unless `ps ux | grep Postgres93.app`.include?('Applications/Postgres93.app')
    pid = spawn('open /Applications/Postgres93.app')
    Process.detach(pid)
  end
  exec 'RAILS_ENV=development foreman start -f ./Procfile.development'
end
DEVELOPMENT

# -----------------------------------------
# spec/controllers
# -----------------------------------------

file "spec/controllers/.keep", ""

# -----------------------------------------
# spec/factories
# -----------------------------------------

file "spec/factories/.keep", ""

# -----------------------------------------
# spec/features
# -----------------------------------------

file "spec/features/.keep", ""

# -----------------------------------------
# spec/features/user_visits_home_page_spec.rb
# -----------------------------------------

file "spec/features/user_visits_home_page_spec.rb", <<-USERVISITSHOMEPAGE
require "spec_helper"

feature "User visits home page" do
  
  it "has the welcome message" do
    visit root_path
    page.should have_content "Welcome to #{@app_name.titleize}"
  end
  
end
USERVISITSHOMEPAGE

# -----------------------------------------
# spec/models
# -----------------------------------------

file "spec/models/.keep", ""

# -----------------------------------------
# spec/spec_helper.rb
# -----------------------------------------

run "rm -rf test"
file "spec/spec_helper.rb", <<-SPECHELPER
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "capybara/rspec"
require "database_cleaner"
require "factory_girl_rails"
require "rspec/rails"
require "rspec/autorun"
Rails.backtrace_cleaner.remove_silencers!

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["\#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include FactoryGirl::Syntax::Methods
  
  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end
SPECHELPER

# -----------------------------------------
# vendor/assets/stylesheets/normalize.css
# -----------------------------------------

file "vendor/assets/stylesheets/normalize.css", <<-NORMALIZECSS
/*! normalize.css v3.0.0 | MIT License | git.io/normalize */

/**
 * 1. Set default font family to sans-serif.
 * 2. Prevent iOS text size adjust after orientation change, without disabling
 *    user zoom.
 */

html {
  font-family: sans-serif; /* 1 */
  -ms-text-size-adjust: 100%; /* 2 */
  -webkit-text-size-adjust: 100%; /* 2 */
}

/**
 * Remove default margin.
 */

body {
  margin: 0;
}

/* HTML5 display definitions
   ========================================================================== */

/**
 * Correct `block` display not defined in IE 8/9.
 */

article,
aside,
details,
figcaption,
figure,
footer,
header,
hgroup,
main,
nav,
section,
summary {
  display: block;
}

/**
 * 1. Correct `inline-block` display not defined in IE 8/9.
 * 2. Normalize vertical alignment of `progress` in Chrome, Firefox, and Opera.
 */

audio,
canvas,
progress,
video {
  display: inline-block; /* 1 */
  vertical-align: baseline; /* 2 */
}

/**
 * Prevent modern browsers from displaying `audio` without controls.
 * Remove excess height in iOS 5 devices.
 */

audio:not([controls]) {
  display: none;
  height: 0;
}

/**
 * Address `[hidden]` styling not present in IE 8/9.
 * Hide the `template` element in IE, Safari, and Firefox < 22.
 */

[hidden],
template {
  display: none;
}

/* Links
   ========================================================================== */

/**
 * Remove the gray background color from active links in IE 10.
 */

a {
  background: transparent;
}

/**
 * Improve readability when focused and also mouse hovered in all browsers.
 */

a:active,
a:hover {
  outline: 0;
}

/* Text-level semantics
   ========================================================================== */

/**
 * Address styling not present in IE 8/9, Safari 5, and Chrome.
 */

abbr[title] {
  border-bottom: 1px dotted;
}

/**
 * Address style set to `bolder` in Firefox 4+, Safari 5, and Chrome.
 */

b,
strong {
  font-weight: bold;
}

/**
 * Address styling not present in Safari 5 and Chrome.
 */

dfn {
  font-style: italic;
}

/**
 * Address variable `h1` font-size and margin within `section` and `article`
 * contexts in Firefox 4+, Safari 5, and Chrome.
 */

h1 {
  font-size: 2em;
  margin: 0.67em 0;
}

/**
 * Address styling not present in IE 8/9.
 */

mark {
  background: #ff0;
  color: #000;
}

/**
 * Address inconsistent and variable font size in all browsers.
 */

small {
  font-size: 80%;
}

/**
 * Prevent `sub` and `sup` affecting `line-height` in all browsers.
 */

sub,
sup {
  font-size: 75%;
  line-height: 0;
  position: relative;
  vertical-align: baseline;
}

sup {
  top: -0.5em;
}

sub {
  bottom: -0.25em;
}

/* Embedded content
   ========================================================================== */

/**
 * Remove border when inside `a` element in IE 8/9.
 */

img {
  border: 0;
}

/**
 * Correct overflow displayed oddly in IE 9.
 */

svg:not(:root) {
  overflow: hidden;
}

/* Grouping content
   ========================================================================== */

/**
 * Address margin not present in IE 8/9 and Safari 5.
 */

figure {
  margin: 1em 40px;
}

/**
 * Address differences between Firefox and other browsers.
 */

hr {
  -moz-box-sizing: content-box;
  box-sizing: content-box;
  height: 0;
}

/**
 * Contain overflow in all browsers.
 */

pre {
  overflow: auto;
}

/**
 * Address odd `em`-unit font size rendering in all browsers.
 */

code,
kbd,
pre,
samp {
  font-family: monospace, monospace;
  font-size: 1em;
}

/* Forms
   ========================================================================== */

/**
 * Known limitation: by default, Chrome and Safari on OS X allow very limited
 * styling of `select`, unless a `border` property is set.
 */

/**
 * 1. Correct color not being inherited.
 *    Known issue: affects color of disabled elements.
 * 2. Correct font properties not being inherited.
 * 3. Address margins set differently in Firefox 4+, Safari 5, and Chrome.
 */

button,
input,
optgroup,
select,
textarea {
  color: inherit; /* 1 */
  font: inherit; /* 2 */
  margin: 0; /* 3 */
}

/**
 * Address `overflow` set to `hidden` in IE 8/9/10.
 */

button {
  overflow: visible;
}

/**
 * Address inconsistent `text-transform` inheritance for `button` and `select`.
 * All other form control elements do not inherit `text-transform` values.
 * Correct `button` style inheritance in Firefox, IE 8+, and Opera
 * Correct `select` style inheritance in Firefox.
 */

button,
select {
  text-transform: none;
}

/**
 * 1. Avoid the WebKit bug in Android 4.0.* where (2) destroys native `audio`
 *    and `video` controls.
 * 2. Correct inability to style clickable `input` types in iOS.
 * 3. Improve usability and consistency of cursor style between image-type
 *    `input` and others.
 */

button,
html input[type="button"], /* 1 */
input[type="reset"],
input[type="submit"] {
  -webkit-appearance: button; /* 2 */
  cursor: pointer; /* 3 */
}

/**
 * Re-set default cursor for disabled elements.
 */

button[disabled],
html input[disabled] {
  cursor: default;
}

/**
 * Remove inner padding and border in Firefox 4+.
 */

button::-moz-focus-inner,
input::-moz-focus-inner {
  border: 0;
  padding: 0;
}

/**
 * Address Firefox 4+ setting `line-height` on `input` using `!important` in
 * the UA stylesheet.
 */

input {
  line-height: normal;
}

/**
 * It's recommended that you don't attempt to style these elements.
 * Firefox's implementation doesn't respect box-sizing, padding, or width.
 *
 * 1. Address box sizing set to `content-box` in IE 8/9/10.
 * 2. Remove excess padding in IE 8/9/10.
 */

input[type="checkbox"],
input[type="radio"] {
  box-sizing: border-box; /* 1 */
  padding: 0; /* 2 */
}

/**
 * Fix the cursor style for Chrome's increment/decrement buttons. For certain
 * `font-size` values of the `input`, it causes the cursor style of the
 * decrement button to change from `default` to `text`.
 */

input[type="number"]::-webkit-inner-spin-button,
input[type="number"]::-webkit-outer-spin-button {
  height: auto;
}

/**
 * 1. Address `appearance` set to `searchfield` in Safari 5 and Chrome.
 * 2. Address `box-sizing` set to `border-box` in Safari 5 and Chrome
 *    (include `-moz` to future-proof).
 */

input[type="search"] {
  -webkit-appearance: textfield; /* 1 */
  -moz-box-sizing: content-box;
  -webkit-box-sizing: content-box; /* 2 */
  box-sizing: content-box;
}

/**
 * Remove inner padding and search cancel button in Safari and Chrome on OS X.
 * Safari (but not Chrome) clips the cancel button when the search input has
 * padding (and `textfield` appearance).
 */

input[type="search"]::-webkit-search-cancel-button,
input[type="search"]::-webkit-search-decoration {
  -webkit-appearance: none;
}

/**
 * Define consistent border, margin, and padding.
 */

fieldset {
  border: 1px solid #c0c0c0;
  margin: 0 2px;
  padding: 0.35em 0.625em 0.75em;
}

/**
 * 1. Correct `color` not being inherited in IE 8/9.
 * 2. Remove padding so people aren't caught out if they zero out fieldsets.
 */

legend {
  border: 0; /* 1 */
  padding: 0; /* 2 */
}

/**
 * Remove default vertical scrollbar in IE 8/9.
 */

textarea {
  overflow: auto;
}

/**
 * Don't inherit the `font-weight` (applied by a rule above).
 * NOTE: the default cannot safely be changed in Chrome and Safari on OS X.
 */

optgroup {
  font-weight: bold;
}

/* Tables
   ========================================================================== */

/**
 * Remove most spacing between table cells.
 */

table {
  border-collapse: collapse;
  border-spacing: 0;
}

td,
th {
  padding: 0;
}
NORMALIZECSS

# -----------------------------------------
# .env
# -----------------------------------------

file ".env", <<-ENV
DEVISE_SECRET_TOKEN=#{SecureRandom.hex(64)}
HOSTNAME=localhost:3000
SECRET_TOKEN=#{SecureRandom.hex(64)}
ENV

# -----------------------------------------
# .gitignore
# -----------------------------------------

run "rm .gitignore"
file ".gitignore", <<-GITIGNORE
# See http://help.github.com/ignore-files/ for more about ignoring files.
#
# If you find yourself ignoring temporary files generated by your text editor
# or operating system, you probably want to add a global ignore instead:
#   git config --global core.excludesfile "~/.gitignore_global"

.DS_Store

# Ignore bundler config.
/.bundle

# Ignore the default SQLite database.
/db/*.sqlite3
/db/*.sqlite3-journal

# Ignore all logfiles and tempfiles.
/log/*.log
/tmp
/bin/log
GITIGNORE

# -----------------------------------------
# .rspec
# -----------------------------------------

file ".rspec", <<-RSPEC
--color
RSPEC

# -----------------------------------------
# .tm_properties
# -----------------------------------------

file ".tm_properties", <<-TMPROPERTIES
includeFiles = "{$includeFiles,.env,.gitignore,.foreman,.travis.yml}"
excludeFiles = "{$excludeFiles,*.sqlite3}"
excludeInFileChooser = "{$excludeInFileChooser,log,tmp}"
excludeInFolderSearch = "{$excludeInFolderSearch,log,tmp}"

softTabs = true
tabSize = 2
TMPROPERTIES

# -----------------------------------------
# Gemfile
# -----------------------------------------

run "rm Gemfile"
file "Gemfile", <<-GEMFILE
source "http://rubygems.org"

ruby "2.0.0"
gem "rails", "4.0.3"

gem "awesome_print"#{install_blogelator ? "\ngem \"blogelator\", github: \"codelation/blogelator\"" : ""}
gem "bourbon"#{install_devise ? "\ngem \"cancan\"" : ""}
gem "coffee-rails"#{install_devise ? "\ngem \"devise\"" : ""}
gem "ember-rails"
gem "ember-source"
gem "font-awesome-sass"
gem "jquery-rails"
gem "local_time"
gem "neat"
gem "newrelic_rpm"
gem "pg"
gem "puma"
gem "roadie"
gem "sass-rails"
gem "uglifier"

group :development, :test do
  gem "better_errors"
  gem "binding_of_caller"
  gem "dotenv-rails"
  gem "foreman"
  gem "letter_opener"
  gem "quiet_assets"
end

group :test do
  gem "capybara"
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "faker"
  gem "guard"
  gem "guard-rspec"
  gem "rb-fsevent"
  gem "rspec-rails"
  gem "terminal-notifier-guard"
  gem "vcr"
  gem "webmock"
end

group :production do
  gem "rails_12factor"
end
GEMFILE

# -----------------------------------------
# Guardfile
# -----------------------------------------

file "Guardfile", <<-GUARDFILE
# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/\#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/\#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$})          { |m| "spec/\#{m[1]}\#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/\#{m[1]}_routing_spec.rb", "spec/\#{m[2]}s/\#{m[1]}_\#{m[2]}_spec.rb", "spec/acceptance/\#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }

  # Capybara features specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$})     { |m| "spec/features/\#{m[1]}_spec.rb" }
end
GUARDFILE

# -----------------------------------------
# Procfile
# -----------------------------------------

file "Procfile", <<-PROCFILE
web: bundle exec puma -t 0:5 -p $PORT -e $RACK_ENV -w 3
PROCFILE

# -----------------------------------------
# Procfile.development
# -----------------------------------------

file "Procfile.development", <<-PROCFILEDEVELOPMENT
web: rails s Puma
PROCFILEDEVELOPMENT

# -----------------------------------------
# README.md
# -----------------------------------------

run "rm README.rdoc"
file "README.md", <<-README
# #{@app_name.titleize}

## Requirements

If you've manage to generate the app, all you 
should need is [Postgres.app](http://postgresapp.com).

The version expected is Postgres93.app. If a different version is used, the
rake command in `lib/tasks/development.rake` will need to be updated to use
the `rake start` command.

## Running Locally

A rake command is included to start up Postgres.app 
if it isn't running already and then start the Rails
app with Puma at <http://localhost:3000>.

```bash
$ rake start
```

## Deployment

This app is made to be deployed to [Heroku](http://heroku.com)
and should work out of the box as long as the environment variables
from `.env` are set on Heroku using `heroku config:set VARIABLE_NAME=VALUE`.

## Installed Gems

### Production/Development/Test

- [Awesome Print](https://github.com/michaeldv/awesome_print)#{install_blogelator ? "\n- [Blogelator](https://github.com/codelation/blogelator)" : ""}
- [Bourbon](http://bourbon.io)#{install_devise ? "\n- [CanCan](https://github.com/ryanb/cancan)" : ""}
- [Coffee-Rails](https://github.com/rails/coffee-rails)#{install_devise ? "\n- [Devise](https://github.com/plataformatec/devise)" : ""}
- [ember-rails](https://github.com/emberjs/ember-rails)
- [jquery-rails](https://github.com/rails/jquery-rails)
- [New Relic Ruby Agent](https://github.com/newrelic/rpm)
- [pg](https://bitbucket.org/ged/ruby-pg)
- [Puma](http://puma.io)
- [Roadie](https://github.com/Mange/roadie)
- [Sass-Rails](https://github.com/rails/sass-rails)
- [Uglifier](https://github.com/lautis/uglifier)

### Development/Test

- [Better Errors](https://github.com/charliesome/better_errors)
- [dotenv](https://github.com/bkeepers/dotenv)
- [Foreman](https://github.com/ddollar/foreman)
- [Letter Opener](https://github.com/ryanb/letter_opener)
- [Quiet Assets](https://github.com/evrone/quiet_assets)

### Test

- [factory_girl](https://github.com/thoughtbot/factory_girl_rails)
- [Faker](https://github.com/stympy/faker)
- [Guard::RSpec](https://github.com/guard/guard-rspec)
- [rb-fsevent](https://github.com/thibaudgg/rb-fsevent)
- [rspec-rails](https://github.com/rspec/rspec-rails)
- [TerminalNotifier for Guard](https://github.com/Springest/terminal-notifier-guard)
- [VCR](https://github.com/vcr/vcr)
- [WebMock](https://github.com/bblimke/webmock)
README

# =================================================================
# Create root route
# =================================================================

route 'root to: "static_pages#home"'

# =================================================================
# Install Gems 
# =================================================================

run "bundle install"

# =================================================================
# Install Blogelator 
# =================================================================

if install_blogelator
  run "rails generate blogelator:install"
end

# =================================================================
# Install Devise 
# =================================================================

if install_devise
  run "rails generate devise:install"
  run "rails generate devise User"
  run "rails generate cancan:ability"
  
  run "rm config/initializers/devise.rb"
  file "config/initializers/devise.rb", <<-DEVISERB
# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  # The secret key used by Devise. Devise uses this key to generate
  # random tokens. Changing this key will render invalid all existing
  # confirmation, reset password and unlock tokens in the database.
  config.secret_key = ENV["DEVISE_SECRET_TOKEN"]

  # ==> Mailer Configuration
  # Configure the e-mail address which will be shown in Devise::Mailer,
  # note that it will be overwritten if you use your own mailer class
  # with default "from" parameter.
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  # Configure the class responsible to send e-mails.
  # config.mailer = 'Devise::Mailer'

  # ==> ORM configuration
  # Load and configure the ORM. Supports :active_record (default) and
  # :mongoid (bson_ext recommended) by default. Other ORMs may be
  # available as additional gems.
  require 'devise/orm/active_record'

  # ==> Configuration for any authentication mechanism
  # Configure which keys are used when authenticating a user. The default is
  # just :email. You can configure it to use [:username, :subdomain], so for
  # authenticating a user, both parameters are required. Remember that those
  # parameters are used only when authenticating and not when retrieving from
  # session. If you need permissions, you should implement that in a before filter.
  # You can also supply a hash where the value is a boolean determining whether
  # or not authentication should be aborted when the value is not present.
  # config.authentication_keys = [ :email ]

  # Configure parameters from the request object used for authentication. Each entry
  # given should be a request method and it will automatically be passed to the
  # find_for_authentication method and considered in your model lookup. For instance,
  # if you set :request_keys to [:subdomain], :subdomain will be used on authentication.
  # The same considerations mentioned for authentication_keys also apply to request_keys.
  # config.request_keys = []

  # Configure which authentication keys should be case-insensitive.
  # These keys will be downcased upon creating or modifying a user and when used
  # to authenticate or find a user. Default is :email.
  config.case_insensitive_keys = [ :email ]

  # Configure which authentication keys should have whitespace stripped.
  # These keys will have whitespace before and after removed upon creating or
  # modifying a user and when used to authenticate or find a user. Default is :email.
  config.strip_whitespace_keys = [ :email ]

  # Tell if authentication through request.params is enabled. True by default.
  # It can be set to an array that will enable params authentication only for the
  # given strategies, for example, `config.params_authenticatable = [:database]` will
  # enable it only for database (email + password) authentication.
  # config.params_authenticatable = true

  # Tell if authentication through HTTP Auth is enabled. False by default.
  # It can be set to an array that will enable http authentication only for the
  # given strategies, for example, `config.http_authenticatable = [:database]` will
  # enable it only for database authentication. The supported strategies are:
  # :database      = Support basic authentication with authentication key + password
  # config.http_authenticatable = false

  # If http headers should be returned for AJAX requests. True by default.
  # config.http_authenticatable_on_xhr = true

  # The realm used in Http Basic Authentication. 'Application' by default.
  # config.http_authentication_realm = 'Application'

  # It will change confirmation, password recovery and other workflows
  # to behave the same regardless if the e-mail provided was right or wrong.
  # Does not affect registerable.
  # config.paranoid = true

  # By default Devise will store the user in session. You can skip storage for
  # particular strategies by setting this option.
  # Notice that if you are skipping storage for all authentication paths, you
  # may want to disable generating routes to Devise's sessions controller by
  # passing :skip => :sessions to `devise_for` in your config/routes.rb
  config.skip_session_storage = [:http_auth]

  # By default, Devise cleans up the CSRF token on authentication to
  # avoid CSRF token fixation attacks. This means that, when using AJAX
  # requests for sign in and sign up, you need to get a new CSRF token
  # from the server. You can disable this option at your own risk.
  # config.clean_up_csrf_token_on_authentication = true

  # ==> Configuration for :database_authenticatable
  # For bcrypt, this is the cost for hashing the password and defaults to 10. If
  # using other encryptors, it sets how many times you want the password re-encrypted.
  #
  # Limiting the stretches to just one in testing will increase the performance of
  # your test suite dramatically. However, it is STRONGLY RECOMMENDED to not use
  # a value less than 10 in other environments.
  config.stretches = Rails.env.test? ? 1 : 10

  # Setup a pepper to generate the encrypted password.
  # config.pepper = '52dd4043b16c1b137c3cfec3c4a32724a47aab6cc728ee8d2c450da0454563a7366a385e99be929a12ecd106676d1107112a035b1d922cff6812732f3d3f9f8f'

  # ==> Configuration for :confirmable
  # A period that the user is allowed to access the website even without
  # confirming their account. For instance, if set to 2.days, the user will be
  # able to access the website for two days without confirming their account,
  # access will be blocked just in the third day. Default is 0.days, meaning
  # the user cannot access the website without confirming their account.
  # config.allow_unconfirmed_access_for = 2.days

  # A period that the user is allowed to confirm their account before their
  # token becomes invalid. For example, if set to 3.days, the user can confirm
  # their account within 3 days after the mail was sent, but on the fourth day
  # their account can't be confirmed with the token any more.
  # Default is nil, meaning there is no restriction on how long a user can take
  # before confirming their account.
  # config.confirm_within = 3.days

  # If true, requires any email changes to be confirmed (exactly the same way as
  # initial account confirmation) to be applied. Requires additional unconfirmed_email
  # db field (see migrations). Until confirmed new email is stored in
  # unconfirmed email column, and copied to email column on successful confirmation.
  config.reconfirmable = true

  # Defines which key will be used when confirming an account
  # config.confirmation_keys = [ :email ]

  # ==> Configuration for :rememberable
  # The time the user will be remembered without asking for credentials again.
  # config.remember_for = 2.weeks

  # If true, extends the user's remember period when remembered via cookie.
  # config.extend_remember_period = false

  # Options to be passed to the created cookie. For instance, you can set
  # :secure => true in order to force SSL only cookies.
  # config.rememberable_options = {}

  # ==> Configuration for :validatable
  # Range for password length.
  config.password_length = 8..128

  # Email regex used to validate email formats. It simply asserts that
  # one (and only one) @ exists in the given string. This is mainly
  # to give user feedback and not to assert the e-mail validity.
  # config.email_regexp = /\\A[^@]+@[^@]+\\z/

  # ==> Configuration for :timeoutable
  # The time you want to timeout the user session without activity. After this
  # time the user will be asked for credentials again. Default is 30 minutes.
  # config.timeout_in = 30.minutes

  # If true, expires auth token on session timeout.
  # config.expire_auth_token_on_timeout = false

  # ==> Configuration for :lockable
  # Defines which strategy will be used to lock an account.
  # :failed_attempts = Locks an account after a number of failed attempts to sign in.
  # :none            = No lock strategy. You should handle locking by yourself.
  # config.lock_strategy = :failed_attempts

  # Defines which key will be used when locking and unlocking an account
  # config.unlock_keys = [ :email ]

  # Defines which strategy will be used to unlock an account.
  # :email = Sends an unlock link to the user email
  # :time  = Re-enables login after a certain amount of time (see :unlock_in below)
  # :both  = Enables both strategies
  # :none  = No unlock strategy. You should handle unlocking by yourself.
  # config.unlock_strategy = :both

  # Number of authentication tries before locking an account if lock_strategy
  # is failed attempts.
  # config.maximum_attempts = 20

  # Time interval to unlock the account if :time is enabled as unlock_strategy.
  # config.unlock_in = 1.hour

  # Warn on the last attempt before the account is locked.
  # config.last_attempt_warning = false

  # ==> Configuration for :recoverable
  #
  # Defines which key will be used when recovering the password for an account
  # config.reset_password_keys = [ :email ]

  # Time interval you can reset your password with a reset password key.
  # Don't put a too small interval or your users won't have the time to
  # change their passwords.
  config.reset_password_within = 6.hours

  # ==> Configuration for :encryptable
  # Allow you to use another encryption algorithm besides bcrypt (default). You can use
  # :sha1, :sha512 or encryptors from others authentication tools as :clearance_sha1,
  # :authlogic_sha512 (then you should set stretches above to 20 for default behavior)
  # and :restful_authentication_sha1 (then you should set stretches to 10, and copy
  # REST_AUTH_SITE_KEY to pepper).
  #
  # Require the `devise-encryptable` gem when using anything other than bcrypt
  # config.encryptor = :sha512

  # ==> Scopes configuration
  # Turn scoped views on. Before rendering "sessions/new", it will first check for
  # "users/sessions/new". It's turned off by default because it's slower if you
  # are using only default views.
  # config.scoped_views = false

  # Configure the default scope given to Warden. By default it's the first
  # devise role declared in your routes (usually :user).
  # config.default_scope = :user

  # Set this configuration to false if you want /users/sign_out to sign out
  # only the current scope. By default, Devise signs out all scopes.
  # config.sign_out_all_scopes = true

  # ==> Navigation configuration
  # Lists the formats that should be treated as navigational. Formats like
  # :html, should redirect to the sign in page when the user does not have
  # access, but formats like :xml or :json, should return 401.
  #
  # If you have any extra navigational formats, like :iphone or :mobile, you
  # should add them to the navigational formats lists.
  #
  # The "*/*" below is required to match Internet Explorer requests.
  # config.navigational_formats = ['*/*', :html]

  # The default HTTP method used to sign out a resource. Default is :delete.
  config.sign_out_via = :delete

  # ==> OmniAuth
  # Add a new OmniAuth provider. Check the wiki for more information on setting
  # up on your models and hooks.
  # config.omniauth :github, 'APP_ID', 'APP_SECRET', :scope => 'user,public_repo'

  # ==> Warden configuration
  # If you want to use other strategies, that are not supported by Devise, or
  # change the failure app, you can configure them inside the config.warden block.
  #
  # config.warden do |manager|
  #   manager.intercept_401 = false
  #   manager.default_strategies(:scope => :user).unshift :some_external_strategy
  # end

  # ==> Mountable engine configurations
  # When using Devise inside an engine, let's call it `MyEngine`, and this engine
  # is mountable, there are some extra configurations to be taken into account.
  # The following options are available, assuming the engine is mounted as:
  #
  #     mount MyEngine, at: '/my_engine'
  #
  # The router that invoked `devise_for`, in the example above, would be:
  # config.router_name = :my_engine
  #
  # When using omniauth, Devise cannot automatically set Omniauth path,
  # so you need to do it manually. For the users scope, it would be:
  # config.omniauth_path_prefix = '/my_engine/users/auth'
end
DEVISERB
end

# =================================================================
# Create the Database
# =================================================================

create_database = !ask("Do you want to create the database? [yes]").downcase.start_with?("n")
if create_database
  rake "db:create"
  
  migrate_database = !ask("Do you want to run the database migrations? [yes]").downcase.start_with?("n")
  if migrate_database
    rake "db:migrate"
  end
end

# =================================================================
# Initialize Git
# =================================================================

git :init
git add: "."
git commit: "-a -m 'Initial commit'"

# =================================================================
# Heroku Instructions
# =================================================================

puts ""
puts "# ================================================================= #"
puts "#                      Heroku Configuration                         #"
puts "# ================================================================= #"
puts ""
puts "Set up the following environment variables:"
puts ""
puts "heroku config:set DEVISE_SECRET_TOKEN=Use `rake secret` to generate"
puts "heroku config:set HOSTNAME=example.com"
puts "heroku config:set SECRET_TOKEN=Use `rake secret` to generate"
puts "heroku config:set SMTP_ADDRESS=smtp.mandrillapp.com"
puts "heroku config:set SMTP_PORT=587"
puts "heroku config:set SMTP_USER_NAME=username"
puts "heroku config:set SMTP_PASSWORD=password"
puts ""

def run_bundle; end