# =================================================================
# Configuration
# =================================================================

domain_name = ask("What is the host name used in the production environment?")

# =================================================================
# Files
# =================================================================

# -----------------------------------------
# app/assets/javascripts/application.js
# -----------------------------------------

run "rm app/assets/javascripts/application.js"
file "app/assets/javascripts/application.js", <<-APPLICATIONJS
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
APPLICATIONJS

# -----------------------------------------
# app/assets/javascripts/application.css
# -----------------------------------------

run "rm app/assets/stylesheets/application.css"
file "app/assets/stylesheets/application.css", <<-APPLICATIONCSS
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, vendor/assets/stylesheets,
 * or vendor/assets/stylesheets of plugins, if any, can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the top of the
 * compiled file, but it's generally better to create a new file per style scope.
 *
 *= require_tree ./#{@app_name.underscore}
 *= require_self
 */
APPLICATIONCSS

# -----------------------------------------
# app/assets/stylesheets/{app_name}/layout/application.scss
# -----------------------------------------

file "app/assets/stylesheets/#{@app_name.underscore}/layout/application.scss", <<-APPLICATIONLAYOUTSCSS
html, body {
  margin: 0;
  padding: 0;
}
APPLICATIONLAYOUTSCSS

# -----------------------------------------
# app/assets/stylesheets/{app_name}/static_pages/home.scss
# -----------------------------------------

file "app/assets/stylesheets/#{@app_name.underscore}/static_pages/home.scss", <<-HOMESCSS
.static-pages.home {
  h1 {
    text-align: center;
  }
}
HOMESCSS

# -----------------------------------------
# app/controllers/static_pages_controller.rb
# -----------------------------------------

file "app/controllers/static_pages_controller.rb", <<-STATICPAGESCONTROLLER
class StaticPagesController < ApplicationController
  
  def home; end
  
end
STATICPAGESCONTROLLER

# -----------------------------------------
# app/views/layouts/application.html.erb
# -----------------------------------------

run "rm app/views/layouts/application.html.erb"
file "app/views/layouts/application.html.erb", <<-APPLICATIONLAYOUT
<!DOCTYPE html>
<html>
<head>
  <title>#{@app_name.titleize}</title>
  <%= stylesheet_link_tag    "application" %>
  <%= javascript_include_tag "application" %>
  <%= csrf_meta_tags %>
</head>
<body>

<%= yield %>

</body>
</html>
APPLICATIONLAYOUT

# -----------------------------------------
# app/views/static_pages/home.html.erb
# -----------------------------------------

file "app/views/static_pages/home.html.erb", <<-HOMEERB
<div class="static-pages home">
  <h1>Welcome to #{@app_name.titleize}</h1>
</div>
HOMEERB

# -----------------------------------------
# config/environments/development.rb
# -----------------------------------------

run "rm config/environments/development.rb"
file "config/environments/development.rb", <<-DEVELOPMENT
#{@app_name.underscore.classify}::Application.configure do
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
#{@app_name.underscore.classify}::Application.configure do
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
  config.action_mailer.default_url_options = { :host => #{ENV["HOSTNAME"]} }
  config.action_mailer.asset_host = "http://#{ENV["HOSTNAME"]}"
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
# .env
# -----------------------------------------

file ".env", <<-ENV
HOSTNAME=#{domain_name}

SMTP_ADDRESS=smtp.mandrillapp.com
SMTP_PORT=587
SMTP_USER_NAME=username
SMTP_PASSWORD=password
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
# .tm_properties
# -----------------------------------------

file ".tm_properties", <<-TMPROPERTIES
includeFiles = "{$includeFiles,.env,.gitignore,.foreman}"
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

gem "awesome_print"
gem "bourbon"
gem "coffee-rails"
gem "ember-rails"
gem "ember-source"
gem "jquery-rails"
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
  gem "factory_girl_rails"
  gem "faker"
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

- [Awesome Print](https://github.com/michaeldv/awesome_print)
- [Bourbon](http://bourbon.io)
- [Coffee-Rails](https://github.com/rails/coffee-rails)
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
# Install gems 
# =================================================================

run "bundle install"

# =================================================================
# Create the database
# =================================================================

create_database = ask("Do you want to create the database? [yes]")
unless create_database.downcase.include?("n")
  rake "db:create"
end

# =================================================================
# Initialize git
# =================================================================

git :init
git add: "."
git commit: "-a -m 'Initial commit'"