Dir["#{File.dirname(__FILE__)}/application/*.rb"].each {|file| require file }

# =================================================================
# Determine the app class name
# =================================================================

@app_class = @app_name.underscore.classify

if @app_name.end_with?("s") && !@app_class.end_with?("s")
  @app_class += "s"
end

# =================================================================
# Ask which Engines should be installed
# =================================================================

install_devise = ask("Do you want to add authentication? [no]").downcase.start_with?("y")
install_blocky = ask("Do you want to add editable content blocks? [no]").downcase.start_with?("y")
install_blogelator = ask("Do you want to add a blog? [no]").downcase.start_with?("y")

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

# =================================================================
# Configuration Files
# =================================================================

run "rm config/environments/development.rb"
run "rm config/environments/production.rb"
run "rm config/initializers/devise.rb"      if install_devise
run "rm config/database.yml"
run "rm config/routes.rb"
run "rm .gitignore"
run "rm Gemfile"

file "config/environments/development.rb", Configurations.development(@app_class)
file "config/environments/production.rb",  Configurations.production(@app_class)
file "config/initializers/devise.rb",      Configurations.devise                  if install_devise
file "config/initializers/smtp.rb",        Configurations.smtp
file "config/database.yml",                Configurations.database(@app_name)
file "config/jshint.json",                 Configurations.jshint
file "config/routes.rb",                   Configurations.routes(@app_class)
file ".env",                               Configurations.env
file ".rspec",                             Configurations.rspec
file ".gitignore",                         Configurations.gitignore
file ".tm_properties",                     Configurations.tm_properties
file "Gemfile",                            Configurations.gemfile(install_blocky, install_blogelator, install_devise)
file "Guardfile",                          Configurations.guardfile
file "Procfile",                           Configurations.procfile
file "Procfile.development",               Configurations.procfile_development

# =================================================================
# Task Files
# =================================================================

file "lib/tasks/development.rake", Tasks.development

# =================================================================
# Spec Files
# =================================================================

run "rm -rf test"

file "spec/controllers/.keep", ""
file "spec/factories/.keep",   ""
file "spec/features/.keep",    ""
file "spec/models/.keep",      ""

file "spec/rails_helper.rb", Spec.rails_helper
file "spec/spec_helper.rb",  Spec.spec_helper

# =================================================================
# Documentation Files
# =================================================================

run "rm README.rdoc"

file "README.md", Documentation.readme(@app_name, install_blocky, install_blogelator, install_devise)

# =================================================================
# Install Gems and Engines
# =================================================================

run "bundle install"

if install_blocky
  run "rails generate blocky:install"
end

if install_blogelator
  run "rails generate blogelator:install"
end

if install_devise
  run "rails generate devise:install"
  run "rails generate devise User"
  run "rails generate cancan:ability"
end

# =================================================================
# Create the Database
# =================================================================

if create_database = !ask("Do you want to create the database? [yes]").downcase.start_with?("n")
  rake "db:create"

  if migrate_database = !ask("Do you want to run the database migrations? [yes]").downcase.start_with?("n")
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
