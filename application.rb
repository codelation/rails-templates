Dir["#{File.dirname(__FILE__)}/application/*.rb"].each {|file| require file }
`open /Applications/Postgres.app`

# =================================================================
# Determine the app class name
# =================================================================

@app_class = @app_name.underscore.classify

if @app_name.end_with?("s") && !@app_class.end_with?("s")
  @app_class += "s"
end

# =================================================================
# Install Gems and Engines
# =================================================================

# -----------------------------------------
# Ask which gems/engines should be added
# -----------------------------------------

install_devise = ask("Do you want to add authentication? [no]").downcase.start_with?("y")
install_blocky = ask("Do you want to add editable content blocks? [no]").downcase.start_with?("y")
install_blogelator = ask("Do you want to add a blog? [no]").downcase.start_with?("y")

# -----------------------------------------
# Install the selected gems/engines
# -----------------------------------------

run "rm config/database.yml"
run "rm Gemfile"

file "config/database.yml", Configurations.database(@app_name)
file "Gemfile",             Configurations.gemfile(install_blocky, install_blogelator, install_devise)

run "bundle install"
rake "db:drop"
rake "db:create"
rake "db:migrate"

if install_blocky
  run "rails g blocky:install"
end

if install_blogelator
  run "rails g blogelator:install"
end

if install_devise
  run "rails g devise:install"
  run "rails g devise User"
  run "rails g cancan:ability"
end

rake "db:migrate"

# Copy routes.rb after generators to avoid errors
run "rm config/routes.rb"
file "config/routes.rb", Configurations.routes(@app_class, install_blocky, install_blogelator)

# =================================================================
# Asset Files
# =================================================================

# -----------------------------------------
# Font Files
# -----------------------------------------

# Vendor Fonts
file "vendor/assets/fonts/#{@app_name.underscore}/font-awesome.zip", Fonts.font_awesome_zip

# Unzip fonts
run "unzip vendor/assets/fonts/#{@app_name.underscore}/font-awesome.zip -d vendor/assets/fonts/#{@app_name.underscore}"

# Delete unzipped files
run "rm vendor/assets/fonts/#{@app_name.underscore}/font-awesome.zip"

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

# Application Stylesheets
file "app/assets/stylesheets/_imports.scss",        Stylesheets.imports(@app_name)
file "app/assets/stylesheets/_variables.scss",      Stylesheets.variables
file "app/assets/stylesheets/application/.keep",    ""
file "app/assets/stylesheets/application.css.scss", Stylesheets.application(@app_name)

# Shared Stylesheets
file "app/assets/stylesheets/shared/body.scss",           Stylesheets.shared_body
file "app/assets/stylesheets/shared/buttons.scss",        Stylesheets.shared_buttons
file "app/assets/stylesheets/shared/devise.scss",         Stylesheets.shared_devise if install_devise
file "app/assets/stylesheets/shared/flash_messages.scss", Stylesheets.shared_flash_messages
file "app/assets/stylesheets/shared/forms.scss",          Stylesheets.shared_forms
file "app/assets/stylesheets/shared/headings.scss",       Stylesheets.shared_headings
file "app/assets/stylesheets/shared/lists.scss",          Stylesheets.shared_lists

# Sass Mixins
file "app/assets/stylesheets/mixins/button.scss", Stylesheets.mixins_button

# Vendor Stylesheets
file "vendor/assets/stylesheets/#{@app_name.underscore}/_bourbon.scss",     Stylesheets.vendor_bourbon
file "vendor/assets/stylesheets/#{@app_name.underscore}/_neat.scss",        Stylesheets.vendor_neat
file "vendor/assets/stylesheets/#{@app_name.underscore}/bourbon.zip",       Stylesheets.vendor_bourbon_zip
file "vendor/assets/stylesheets/#{@app_name.underscore}/neat.zip",          Stylesheets.vendor_neat_zip
file "vendor/assets/stylesheets/#{@app_name.underscore}/font-awesome.scss", Stylesheets.vendor_font_awesome
file "vendor/assets/stylesheets/#{@app_name.underscore}/font-awesome.zip",  Stylesheets.vendor_font_awesome_zip
file "vendor/assets/stylesheets/#{@app_name.underscore}/normalize.css",     Stylesheets.vendor_normalize

# Unzip additional stylesheets
run "unzip vendor/assets/stylesheets/#{@app_name.underscore}/bourbon.zip -d vendor/assets/stylesheets/#{@app_name.underscore}"
run "unzip vendor/assets/stylesheets/#{@app_name.underscore}/font-awesome.zip -d vendor/assets/stylesheets/#{@app_name.underscore}"
run "unzip vendor/assets/stylesheets/#{@app_name.underscore}/neat.zip -d vendor/assets/stylesheets/#{@app_name.underscore}"
file "vendor/assets/stylesheets/#{@app_name.underscore}/font-awesome/_font-awesome-sprockets.scss",  Stylesheets.vendor_font_awesome_sprockets(@app_name)

# Delete unzipped files
run "rm vendor/assets/stylesheets/#{@app_name.underscore}/bourbon.zip"
run "rm vendor/assets/stylesheets/#{@app_name.underscore}/font-awesome.zip"
run "rm vendor/assets/stylesheets/#{@app_name.underscore}/neat.zip"


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

file "app/views/devise/confirmations/new.html.erb",        Views.devise_confirmations_new if install_devise
file "app/views/devise/passwords/edit.html.erb",           Views.devise_passwords_edit    if install_devise
file "app/views/devise/passwords/new.html.erb",            Views.devise_passwords_new     if install_devise
file "app/views/devise/registrations/new.html.erb",        Views.devise_registrations_new if install_devise
file "app/views/devise/sessions/new.html.erb",             Views.devise_sessions_new      if install_devise
file "app/views/devise/unlocks/new.html.erb",              Views.devise_unlocks_new       if install_devise
file "app/views/layouts/application/_footer.html.erb",     Views.layouts_application_footer
file "app/views/layouts/application/_header.html.erb",     Views.layouts_application_header(@app_name)
file "app/views/layouts/shared/_analytics.html.erb",       Views.layouts_shared_analytics
file "app/views/layouts/shared/_flash_messages.html.erb",  Views.layouts_shared_flash_messages
file "app/views/layouts/application.html.erb",             Views.layouts_application

# =================================================================
# Configuration Files
# =================================================================

run "rm config/environments/development.rb"
run "rm config/environments/production.rb"
run "rm config/initializers/devise.rb"      if install_devise

run "rm .gitignore"

file "config/environments/development.rb", Configurations.development(@app_class)
file "config/environments/production.rb",  Configurations.production(@app_class)
file "config/initializers/devise.rb",      Configurations.devise                  if install_devise
file "config/initializers/smtp.rb",        Configurations.smtp
file "config/jshint.json",                 Configurations.jshint
file ".env",                               Configurations.env
file ".rspec",                             Configurations.rspec
file ".gitignore",                         Configurations.gitignore
file ".tm_properties",                     Configurations.tm_properties
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
# Initialize Git
# =================================================================

# Make sure all files have been generated before first commit
run "bundle exec spring binstub --all"

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
