Dir["#{File.dirname(__FILE__)}/application/*.rb"].each {|file| require file }
Dir["#{File.dirname(__FILE__)}/saas/*.rb"].each        {|file| require file }
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

install_devise = true
install_blocky = ask("Do you want to add editable content blocks? [no]").downcase.start_with?("y")
install_blogelator = ask("Do you want to add a blog? [no]").downcase.start_with?("y")

# -----------------------------------------
# Install the selected gems/engines
# -----------------------------------------

run "rm config/database.yml"
run "rm Gemfile"

file "config/database.yml", Saas::Configurations.database(@app_name)
file "Gemfile",             Saas::Configurations.gemfile(install_blocky, install_blogelator)

run "bundle install"

if install_blocky
  run "rails g blocky:install"
end

if install_blogelator
  run "rails g blogelator:install"
end

# Copy routes.rb after generators to avoid errors
run "rm config/routes.rb"
file "config/routes.rb", Saas::Configurations.routes(@app_class, install_blocky, install_blogelator)

# =================================================================
# Asset Files
# =================================================================

# -----------------------------------------
# Font Files
# -----------------------------------------

# Vendor Fonts
file "vendor/assets/fonts/#{@app_name.underscore}/font-awesome.zip",  Fonts.font_awesome_zip

# Unzip fonts
run "unzip vendor/assets/fonts/#{@app_name.underscore}/font-awesome.zip -d vendor/assets/fonts/#{@app_name.underscore}"

# Delete unzipped files
run "rm vendor/assets/fonts/#{@app_name.underscore}/font-awesome.zip"

# -----------------------------------------
# Image Files
# -----------------------------------------

file "app/assets/images/logo.png", Saas::Images.logo

# -----------------------------------------
# Javascript Files
# -----------------------------------------

run "rm app/assets/javascripts/application.js"

file "app/assets/javascripts/application/.keep",                             ""
file "app/assets/javascripts/home/.keep",                                    ""
file "app/assets/javascripts/application/subscriptions/new.js",              Saas::Javascripts.application_subscriptions_new
file "app/assets/javascripts/application/user_account/organizations/new.js", Saas::Javascripts.application_user_account_organizations_new
file "app/assets/javascripts/shared/flash_messages.js",                      Saas::Javascripts.flash_messages
file "app/assets/javascripts/application.js",                                Saas::Javascripts.application
file "app/assets/javascripts/home.js",                                       Saas::Javascripts.home
file "vendor/assets/javascripts/moment.js",                                  Saas::Javascripts.vendor_moment

# -----------------------------------------
# Stylesheet Files
# -----------------------------------------

run "rm app/assets/stylesheets/application.css"

# Application Stylesheets
file "app/assets/stylesheets/_imports.scss",                   Saas::Stylesheets.imports(@app_name)
file "app/assets/stylesheets/_variables.scss",                 Saas::Stylesheets.variables
file "app/assets/stylesheets/application/layout/_footer.scss", Saas::Stylesheets.application_layout_footer
file "app/assets/stylesheets/application/layout/_header.scss", Saas::Stylesheets.application_layout_header
file "app/assets/stylesheets/application/layout/fonts.scss",   Saas::Stylesheets.application_layout_fonts
file "app/assets/stylesheets/application/layout/title.scss",   Saas::Stylesheets.application_layout_title
file "app/assets/stylesheets/application/.keep",               ""
file "app/assets/stylesheets/application.css.scss",            Saas::Stylesheets.application(@app_name)

file "app/assets/stylesheets/application/organization_account/layout.scss", Saas::Stylesheets.application_organization_account_layout

file "app/assets/stylesheets/application/payment_methods/edit.scss", Saas::Stylesheets.application_payment_methods_edit
file "app/assets/stylesheets/application/subscriptions/edit.scss",   Saas::Stylesheets.application_subscriptions_edit
file "app/assets/stylesheets/application/subscriptions/new.scss",    Saas::Stylesheets.application_subscriptions_new

file "app/assets/stylesheets/application/user_account/organization_memberships/index.scss", Saas::Stylesheets.application_user_account_organization_memberships_index
file "app/assets/stylesheets/application/user_account/organizations/new.scss",              Saas::Stylesheets.application_user_account_organizations_new
file "app/assets/stylesheets/application/user_account/layout.scss",                         Saas::Stylesheets.application_user_account_layout

# Home Styleshseets
file "app/assets/stylesheets/home/.keep",                      ""
file "app/assets/stylesheets/home.css.scss",                   Saas::Stylesheets.home(@app_name)
file "app/assets/stylesheets/home/layout/_footer.scss",        Saas::Stylesheets.home_footer
file "app/assets/stylesheets/home/layout/_header.scss",        Saas::Stylesheets.home_header
file "app/assets/stylesheets/home/layout/fonts.scss",          Saas::Stylesheets.home_fonts
file "app/assets/stylesheets/home/layout/title.scss",          Saas::Stylesheets.home_title
file "app/assets/stylesheets/home/contact_messages/main.scss", Saas::Stylesheets.contact_messages_main
file "app/assets/stylesheets/home/home/index/header.scss",     Saas::Stylesheets.home_index_header
file "app/assets/stylesheets/home/home/index/sign_up.scss",    Saas::Stylesheets.home_index_sign_up
file "app/assets/stylesheets/home/home/features.scss",         Saas::Stylesheets.home_features
file "app/assets/stylesheets/home/home/index.scss",            Saas::Stylesheets.home_index
file "app/assets/stylesheets/home/home/pricing.scss",          Saas::Stylesheets.home_pricing
file "app/assets/stylesheets/home/home/privacy.scss",          Saas::Stylesheets.home_privacy
file "app/assets/stylesheets/home/home/terms.scss",            Saas::Stylesheets.home_terms

# Shared Stylesheets
file "app/assets/stylesheets/shared/body.scss",                                  Saas::Stylesheets.shared_body
file "app/assets/stylesheets/shared/buttons.scss",                               Saas::Stylesheets.shared_buttons
file "app/assets/stylesheets/shared/devise.scss",                                Saas::Stylesheets.shared_devise
file "app/assets/stylesheets/shared/forms.scss",                                 Saas::Stylesheets.shared_forms
file "app/assets/stylesheets/shared/headings.scss",                              Saas::Stylesheets.shared_headings
file "app/assets/stylesheets/shared/lists.scss",                                 Saas::Stylesheets.shared_lists
file "app/assets/stylesheets/shared/flash_messages.scss",                        Saas::Stylesheets.shared_flash_messages
file "app/assets/stylesheets/shared/tables.scss",                                Saas::Stylesheets.shared_tables
file "app/assets/stylesheets/shared/subscription_plans/_subscription_plan.scss", Saas::Stylesheets.shared_subscription_plan

# Sass Mixins
file "app/assets/stylesheets/mixins/button.scss",              Saas::Stylesheets.mixins_button
file "app/assets/stylesheets/mixins/vertical_navigation.scss", Saas::Stylesheets.mixins_vertical_navigation

# Vendor Stylesheets
file "vendor/assets/stylesheets/#{@app_name.underscore}/_bourbon.scss",     Saas::Stylesheets.vendor_bourbon
file "vendor/assets/stylesheets/#{@app_name.underscore}/_neat.scss",        Saas::Stylesheets.vendor_neat
file "vendor/assets/stylesheets/#{@app_name.underscore}/bourbon.zip",       Saas::Stylesheets.vendor_bourbon_zip
file "vendor/assets/stylesheets/#{@app_name.underscore}/neat.zip",          Saas::Stylesheets.vendor_neat_zip
file "vendor/assets/stylesheets/#{@app_name.underscore}/font-awesome.scss", Saas::Stylesheets.vendor_font_awesome
file "vendor/assets/stylesheets/#{@app_name.underscore}/font-awesome.zip",  Saas::Stylesheets.vendor_font_awesome_zip
file "vendor/assets/stylesheets/#{@app_name.underscore}/normalize.css",     Saas::Stylesheets.vendor_normalize

# Unzip additional stylesheets
run "unzip vendor/assets/stylesheets/#{@app_name.underscore}/bourbon.zip -d vendor/assets/stylesheets/#{@app_name.underscore}"
run "unzip vendor/assets/stylesheets/#{@app_name.underscore}/font-awesome.zip -d vendor/assets/stylesheets/#{@app_name.underscore}"
run "unzip vendor/assets/stylesheets/#{@app_name.underscore}/neat.zip -d vendor/assets/stylesheets/#{@app_name.underscore}"
file "vendor/assets/stylesheets/#{@app_name.underscore}/font-awesome/_font-awesome-sprockets.scss",  Saas::Stylesheets.vendor_font_awesome_sprockets(@app_name)

# Delete unzipped files
run "rm vendor/assets/stylesheets/#{@app_name.underscore}/bourbon.zip"
run "rm vendor/assets/stylesheets/#{@app_name.underscore}/font-awesome.zip"
run "rm vendor/assets/stylesheets/#{@app_name.underscore}/neat.zip"


# =================================================================
# App Files
# =================================================================

# -----------------------------------------
# Controller Files
# -----------------------------------------

file "app/controllers/authentication/confirmations_controller.rb", Saas::Controllers.confirmations_controller
file "app/controllers/authentication/passwords_controller.rb",     Saas::Controllers.passwords_controller
file "app/controllers/authentication/registrations_controller.rb", Saas::Controllers.registrations_controller
file "app/controllers/authentication/sessions_controller.rb",      Saas::Controllers.sessions_controller
file "app/controllers/authentication/unlocks_controller.rb",       Saas::Controllers.unlocks_controller

file "app/controllers/organization_account/base_controller.rb",                     Saas::Controllers.organization_account_base_controller
file "app/controllers/organization_account/organization_memberships_controller.rb", Saas::Controllers.organization_account_organization_memberships_controller
file "app/controllers/organization_account/organizations_controller.rb",            Saas::Controllers.organization_account_organizations_controller
file "app/controllers/organization_account/payment_methods_controller.rb",          Saas::Controllers.organization_account_payment_methods_controller
file "app/controllers/organization_account/stripe_cards_controller.rb",             Saas::Controllers.organization_account_stripe_cards_controller
file "app/controllers/organization_account/subscriptions_controller.rb",            Saas::Controllers.organization_account_subscriptions_controller

file "app/controllers/user_account/base_controller.rb",                     Saas::Controllers.user_account_base_controller
file "app/controllers/user_account/organization_memberships_controller.rb", Saas::Controllers.user_account_organization_memberships_controller
file "app/controllers/user_account/organizations_controller.rb",            Saas::Controllers.user_account_organizations_controller
file "app/controllers/user_account/payment_methods_controller.rb",          Saas::Controllers.user_account_payment_methods_controller
file "app/controllers/user_account/stripe_cards_controller.rb",             Saas::Controllers.user_account_stripe_cards_controller
file "app/controllers/user_account/subscriptions_controller.rb",            Saas::Controllers.user_account_subscriptions_controller
file "app/controllers/user_account/users_controller.rb",                    Saas::Controllers.user_account_users_controller

file "app/controllers/contact_messages_controller.rb", Saas::Controllers.contact_messages_controller
file "app/controllers/home_controller.rb",             Saas::Controllers.home_controller


# -----------------------------------------
# Helper Files
# -----------------------------------------

run "rm app/helpers/application_helper.rb"
file "app/helpers/application_helper.rb", Helpers.application(@app_name)

# -----------------------------------------
# Model Files
# -----------------------------------------

file "app/models/ability.rb",                 Saas::Models.ability
file "app/models/admin_user.rb",              Saas::Models.admin_user
file "app/models/charge.rb",                  Saas::Models.charge
file "app/models/contact_message.rb",         Saas::Models.contact_message
file "app/models/invoice.rb",                 Saas::Models.invoice
file "app/models/line_item.rb",               Saas::Models.line_item
file "app/models/organization_membership.rb", Saas::Models.organization_membership
file "app/models/organization_role.rb",       Saas::Models.organization_role
file "app/models/organization.rb",            Saas::Models.organization
file "app/models/payment_method.rb",          Saas::Models.payment_method
file "app/models/stripe_card.rb",             Saas::Models.stripe_card
file "app/models/subscription.rb",            Saas::Models.subscription
file "app/models/subscription_plan.rb",       Saas::Models.subscription_plan
file "app/models/user.rb",                    Saas::Models.user

# -----------------------------------------
# Spec Files
# -----------------------------------------

file "spec/models/charge.rb",              Saas::Specs.charge
file "spec/models/invoice.rb",             Saas::Specs.invoice
file "spec/models/line_item.rb",           Saas::Specs.line_item
file "spec/models/organization.rb",        Saas::Specs.organization
file "spec/models/stripe_card.rb",         Saas::Specs.stripe_card
file "spec/models/subscription.rb",        Saas::Specs.subscription
file "spec/models/subscription_plan.rb",   Saas::Specs.subscription_plan
file "spec/models/user.rb",                Saas::Specs.user
file "spec/web_mock/stripe_card.json",     Saas::Specs.web_mock_stripe_card
file "spec/web_mock/stripe_customer.json", Saas::Specs.web_mock_stripe_customer

# -----------------------------------------
# Factory Girl Files
# -----------------------------------------

file "spec/factories/charge_factory.rb",                  Saas::Factories.charge_factory
file "spec/factories/invoice_factory.rb",                 Saas::Factories.invoice_factory
file "spec/factories/line_item_factory.rb",               Saas::Factories.line_item_factory
file "spec/factories/organization_factory.rb",            Saas::Factories.organization_factory
file "spec/factories/organization_membership_factory.rb", Saas::Factories.organization_membership_factory
file "spec/factories/organization_role_factory.rb",       Saas::Factories.organization_role_factory
file "spec/factories/stripe_card_factory.rb",             Saas::Factories.stripe_card_factory
file "spec/factories/subscription_factory.rb",            Saas::Factories.subscription_factory
file "spec/factories/subscription_plan_factory.rb",       Saas::Factories.subscription_plan_factory
file "spec/factories/user_factory.rb",                    Saas::Factories.user_factory

# -----------------------------------------
# Concern Files
# -----------------------------------------

file "app/models/concerns/subscriber.rb",       Saas::Concerns.subscriber
file "spec/models/concerns/subscriber_spec.rb", Saas::Concerns.subscriber_spec

# -----------------------------------------
# Mailer Files
# -----------------------------------------

file "app/mailers/contact_message_mailer.rb", Saas::Mailers.contact_message(@app_name)

# -----------------------------------------
# View Files
# -----------------------------------------

run "rm app/views/layouts/application.html.erb"

file "app/views/contact_message_mailer/contact_email.html.erb",  Saas::Views.contact_message_mailer_contact_email

file "app/views/authentication/confirmations/new.html.erb",      Saas::Views.devise_confirmations_new
file "app/views/authentication/passwords/edit.html.erb",         Saas::Views.devise_passwords_edit
file "app/views/authentication/passwords/new.html.erb",          Saas::Views.devise_passwords_new
file "app/views/authentication/registrations/new.html.erb",      Saas::Views.devise_registrations_new
file "app/views/authentication/sessions/new.html.erb",           Saas::Views.devise_sessions_new
file "app/views/authentication/unlocks/new.html.erb",            Saas::Views.devise_unlocks_new

file "app/views/contact_messages/new.html.erb",                  Saas::Views.contact_messages_new
file "app/views/contact_messages/show.html.erb",                 Saas::Views.contact_messages_show

file "app/views/home/about.html.erb",                            Saas::Views.home_about
file "app/views/home/features.html.erb",                         Saas::Views.home_features
file "app/views/home/index.html.erb",                            Saas::Views.home_index
file "app/views/home/pricing.html.erb",                          Saas::Views.home_pricing
file "app/views/home/privacy.html.erb",                          Saas::Views.home_privacy
file "app/views/home/terms.html.erb",                            Saas::Views.home_terms

file "app/views/layouts/application/_footer.html.erb",           Saas::Views.application_footer
file "app/views/layouts/application/_header.html.erb",           Saas::Views.application_header
file "app/views/layouts/home/_footer.html.erb",                  Saas::Views.home_footer
file "app/views/layouts/home/_header.html.erb",                  Saas::Views.home_header
file "app/views/layouts/shared/_analytics.html.erb",             Saas::Views.analytics
file "app/views/layouts/shared/_flash_messages.html.erb",        Saas::Views.flash_messages
file "app/views/layouts/home.html.erb",                          Saas::Views.home
file "app/views/layouts/application.html.erb",                   Saas::Views.application

file "app/views/organization_account/organization_memberships/index.html.erb", Saas::Views.organization_account_organization_memberships_index
file "app/views/organization_account/organizations/edit.html.erb",             Saas::Views.organization_account_organizations_edit
file "app/views/organization_account/payment_methods/edit.html.erb",           Saas::Views.organization_account_payment_methods_edit
file "app/views/organization_account/subscriptions/edit.html.erb",             Saas::Views.organization_account_subscriptions_edit
file "app/views/organization_account/subscriptions/new.html.erb",              Saas::Views.organization_account_subscriptions_new
file "app/views/organization_account/_sidebar.html.erb",                       Saas::Views.organization_account_sidebar

file "app/views/subscription_plans/_subscription_plan.html.erb", Saas::Views.subscription_plans_subscription_plan

file "app/views/user_account/organization_memberships/index.html.erb", Saas::Views.user_account_organization_memberships_index
file "app/views/user_account/organizations/new.html.erb",              Saas::Views.user_account_organizations_new
file "app/views/user_account/payment_methods/edit.html.erb",           Saas::Views.user_account_payment_methods_edit
file "app/views/user_account/subscriptions/edit.html.erb",             Saas::Views.user_account_subscriptions_edit
file "app/views/user_account/subscriptions/new.html.erb",              Saas::Views.user_account_subscriptions_new
file "app/views/user_account/users/edit.html.erb",                     Saas::Views.user_account_users_edit
file "app/views/user_account/_sidebar.html.erb",                       Saas::Views.user_account_sidebar

# =================================================================
# Configuration Files
# =================================================================

run "rm config/environments/development.rb"
run "rm config/environments/production.rb"

run "rm .gitignore"

file "config/environments/development.rb", Saas::Configurations.development(@app_class)
file "config/environments/production.rb",  Saas::Configurations.production(@app_class)
file "config/initializers/devise.rb",      Saas::Configurations.devise
file "config/initializers/smtp.rb",        Saas::Configurations.smtp
file "config/initializers/stripe.rb",      Saas::Configurations.stripe
file "config/jshint.json",                 Saas::Configurations.jshint
file ".env",                               Saas::Configurations.env
file ".rspec",                             Saas::Configurations.rspec
file ".gitignore",                         Saas::Configurations.gitignore
file ".tm_properties",                     Saas::Configurations.tm_properties
file "Guardfile",                          Saas::Configurations.guardfile
file "Procfile",                           Saas::Configurations.procfile
file "Procfile.development",               Saas::Configurations.procfile_development

# =================================================================
# Migration Files
# =================================================================

file "db/migrate/#{(Time.now + 0).strftime("%Y%m%d%H%M%S")}_create_admin_users.rb",              Saas::Migrations.create_admin_users
file "db/migrate/#{(Time.now + 1).strftime("%Y%m%d%H%M%S")}_create_charges.rb",                  Saas::Migrations.create_charges
file "db/migrate/#{(Time.now + 2).strftime("%Y%m%d%H%M%S")}_create_contact_messages.rb",         Saas::Migrations.create_contact_messages
file "db/migrate/#{(Time.now + 3).strftime("%Y%m%d%H%M%S")}_create_invoices.rb",                 Saas::Migrations.create_invoices
file "db/migrate/#{(Time.now + 4).strftime("%Y%m%d%H%M%S")}_create_line_items.rb",               Saas::Migrations.create_line_items
file "db/migrate/#{(Time.now + 5).strftime("%Y%m%d%H%M%S")}_create_organization_memberships.rb", Saas::Migrations.create_organization_memberships
file "db/migrate/#{(Time.now + 6).strftime("%Y%m%d%H%M%S")}_create_organization_roles.rb",       Saas::Migrations.create_organization_roles
file "db/migrate/#{(Time.now + 7).strftime("%Y%m%d%H%M%S")}_create_organizations.rb",            Saas::Migrations.create_organizations
file "db/migrate/#{(Time.now + 8).strftime("%Y%m%d%H%M%S")}_create_stripe_cards.rb",             Saas::Migrations.create_stripe_cards
file "db/migrate/#{(Time.now + 9).strftime("%Y%m%d%H%M%S")}_create_subscription_plans.rb",       Saas::Migrations.create_subscription_plans
file "db/migrate/#{(Time.now + 10).strftime("%Y%m%d%H%M%S")}_create_subscriptions.rb",           Saas::Migrations.create_subscriptions
file "db/migrate/#{(Time.now + 11).strftime("%Y%m%d%H%M%S")}_create_users.rb",                   Saas::Migrations.create_users

# =================================================================
# DB Seed Files
# =================================================================

run "rm db/seeds.rb"

file "db/seeds/admin_user_seeds.rb",        Saas::Seeds.admin_user_seeds
file "db/seeds/subscription_plan_seeds.rb", Saas::Seeds.subscription_plan_seeds
file "db/seeds.rb",                         Saas::Seeds.seeds

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
rake "db:drop"
rake "db:create"
rake "db:migrate"
rake "db:seed"

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
