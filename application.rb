Dir["#{File.dirname(__FILE__)}/application/*.rb"].each {|file| require file }

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

if install_devise = ask("Do you want to add authentication? [no]").downcase.start_with?("y")
  run "rails generate devise:install"
  run "rails generate devise User"
  run "rails generate cancan:ability"
end

# =================================================================
# Ask if Blogelator should be installed
# =================================================================

if install_blogelator = ask("Do you want to add a blog? [no]").downcase.start_with?("y")
end

# =================================================================
# Asset Files
# =================================================================

# -----------------------------------------
# Javascript Files
# -----------------------------------------

run "rm app/assets/javascripts/application.js"
file "app/assets/javascripts/application/.keep", ""

file "app/assets/javascripts/application.js",           Javascripts.application
file "app/assets/javascripts/shared/flash_messages.js", Javascripts.flash_messages

# -----------------------------------------
# Stylesheet Files
# -----------------------------------------

run "rm app/assets/stylesheets/application.css"

file "app/assets/stylesheets/_imports.scss",                   Stylesheets.imports
file "app/assets/stylesheets/_variables.scss",                 Stylesheets.variables
file "app/assets/stylesheets/application.css.scss",            Stylesheets.application
file "app/assets/stylesheets/shared/typography/body.scss",     Stylesheets.body
file "app/assets/stylesheets/shared/typography/forms.scss",    Stylesheets.forms
file "app/assets/stylesheets/shared/typography/headings.scss", Stylesheets.headings
file "app/assets/stylesheets/shared/typography/lists.scss",    Stylesheets.lists
file "app/assets/stylesheets/shared/buttons.scss",             Stylesheets.buttons
file "app/assets/stylesheets/shared/devise.scss",              Stylesheets.devise if install_devise
file "app/assets/stylesheets/shared/flash_messages.scss",      Stylesheets.flash_messages
file "vendor/assets/stylesheets/normalize.css",                Stylesheets.normalize

# =================================================================
# App Files
# =================================================================

# -----------------------------------------
# Helper Files
# -----------------------------------------

run "rm app/helpers/application_helper.rb"
file "app/helpers/application_helper.rb", Helpers.application(@app_name)

# -----------------------------------------
# View Files
# -----------------------------------------

run "rm app/views/layouts/application.html.erb"

file "app/views/devise/confirmations/new.html.erb", Views.devise_confirmations_new if install_devise
file "app/views/devise/passwords/edit.html.erb",    Views.devise_passwords_edit    if install_devise
file "app/views/devise/passwords/new.html.erb",     Views.devise_passwords_new     if install_devise
file "app/views/devise/registrations/new.html.erb", Views.devise_registrations_new if install_devise
file "app/views/devise/sessions/new.html.erb",      Views.devise_sessions_new      if install_devise
file "app/views/devise/unlocks/new.html.erb",       Views.devise_unlocks_new       if install_devise
file "app/views/layouts/_analytics.html.erb",       Views.analytics
file "app/views/layouts/_flash_messages.html.erb",  Views.flash_messages
file "app/views/layouts/_footer.html.erb",          Views.footer
file "app/views/layouts/_header.html.erb",          Views.header(@app_name)
file "app/views/layouts/application.html.erb",      Views.application

# -----------------------------------------
# Configuration Files
# -----------------------------------------

run "rm config/environments/development.rb"
run "rm config/environments/production.rb"
run "rm config/initializers/devise.rb"      if install_devise
run "rm config/database.yml"
run "rm config/routes.rb"
run "rm Gemfile"

file "config/environments/development.rb", Configurations.development(@app_class)
file "config/environments/production.rb",  Configurations.production(@app_class)
file "config/initializers/devise.rb",      Configurations.devise                  if install_devise
file "config/initializers/smtp.rb",        Configurations.smtp
file "config/database.yml",                Configurations.database(@app_name)
file "config/jshint.json",                 Configurations.jshint
file "config/routes.rb",                   Configurations.routes(@app_class)
file ".tm_properties",                     Configurations.tm_properties
file "Gemfile",                            Configurations.gemfile(install_blogelator, install_devise)

# -----------------------------------------
# lib/tasks/development.rake
# -----------------------------------------

file "lib/tasks/development.rake", <<-DEVELOPMENT
desc "Start the server in development mode"
task :start => :environment do
  `open /Applications/Postgres.app`
  exec "RAILS_ENV=development foreman start -f ./Procfile.development"
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
# spec/javascripts/controllers
# -----------------------------------------

file "spec/javascripts/controllers/.keep", ""

# -----------------------------------------
# spec/javascripts/fixtures
# -----------------------------------------

file "spec/javascripts/fixtures/.keep", ""

# -----------------------------------------
# spec/javascripts/models
# -----------------------------------------

file "spec/javascripts/models/.keep", ""

# -----------------------------------------
# spec/javascripts/routes
# -----------------------------------------

file "spec/javascripts/routes/.keep", ""

# -----------------------------------------
# spec/javascripts/support
# -----------------------------------------

file "spec/javascripts/support/.keep", ""

# -----------------------------------------
# spec/javascripts/spec_helper.js
# -----------------------------------------

file "spec/javascripts/spec_helper.js", <<-SPECHELPERJS

SPECHELPERJS

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
      VCR.use_cassette(:factory_girl) do
        FactoryGirl.lint
      end
    ensure
      DatabaseCleaner.clean
    end
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
end
SPECHELPER

# -----------------------------------------
# .env
# -----------------------------------------

file ".env", <<-ENV
DEVISE_SECRET_TOKEN=#{SecureRandom.hex(64)}
HOSTNAME=localhost:3000
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
# Guardfile
# -----------------------------------------

file "Guardfile", <<-GUARDFILE
# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec do
  watch(%r{^spec/.+_spec.rb$})
  watch(%r{^lib/(.+).rb$})     {|m| "spec/lib/\#{m[1]}_spec.rb" }
  watch("spec/spec_helper.rb") { "spec" }

  # Rails example
  watch(%r{^app/(.+).rb$})                           {|m| "spec/\#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(.erb|.haml|.slim)$})            {|m| "spec/\#{m[1]}\#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller).rb$})  {|m| ["spec/routing/\#{m[1]}_routing_spec.rb", "spec/\#{m[2]}s/\#{m[1]}_\#{m[2]}_spec.rb", "spec/acceptance/\#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+).rb$})                  { "spec" }
  watch("config/routes.rb")                          { "spec/routing" }
  watch("app/controllers/application_controller.rb") { "spec/controllers" }

  # Capybara features specs
  watch(%r{^app/views/(.+)/.*.(erb|haml|slim)$})     {|m| "spec/features/\#{m[1]}_spec.rb" }
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

- [Awesome Print](https://github.com/michaeldv/awesome_print)#{install_blogelator ? "\n- [Blogelator](https://github.com/codelation/blogelator)" : ""}#{install_devise ? "\n- [CanCan](https://github.com/ryanb/cancan)" : ""}
- [Coffee-Rails](https://github.com/rails/coffee-rails)#{install_devise ? "\n- [Devise](https://github.com/plataformatec/devise)" : ""}
- [ember-rails](https://github.com/emberjs/ember-rails)
- [jquery-rails](https://github.com/rails/jquery-rails)
- [pg](https://bitbucket.org/ged/ruby-pg)
- [Puma](http://puma.io)
- [Roadie](https://github.com/Mange/roadie)
- [Sass-Rails](https://github.com/rails/sass-rails)
- [Uglifier](https://github.com/lautis/uglifier)

### Development/Test

- [dotenv](https://github.com/bkeepers/dotenv)
- [Foreman](https://github.com/ddollar/foreman)
- [Letter Opener](https://github.com/fgrehm/letter_opener_web)
- [Quiet Assets](https://github.com/evrone/quiet_assets)

### Test

- [factory_girl](https://github.com/thoughtbot/factory_girl_rails)
- [Faker](https://github.com/stympy/faker)
- [Guard::RSpec](https://github.com/guard/guard-rspec)
- [rb-fsevent](https://github.com/thibaudgg/rb-fsevent)
- [rspec-rails](https://github.com/rspec/rspec-rails)
- [TerminalNotifier for Guard](https://github.com/Springest/terminal-notifier-guard)
- [WebMock](https://github.com/bblimke/webmock)
README

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
puts "heroku config:set SECRET_KEY_BASE=Use `rake secret` to generate"
puts "heroku config:set SMTP_ADDRESS=smtp.mandrillapp.com"
puts "heroku config:set SMTP_PORT=587"
puts "heroku config:set SMTP_USER_NAME=username"
puts "heroku config:set SMTP_PASSWORD=password"
puts ""

def run_bundle; end
