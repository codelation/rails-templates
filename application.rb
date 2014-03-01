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
$base-font-size: 1em;
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

domain_name = ask("What is the host name used in the production environment?")
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

gem "awesome_print"#{install_blogelator ? "\ngem \"blogelator\", github: \"codelation/blogelator\"" : ""}
gem "bourbon"#{install_devise ? "\ngem \"cancan\"" : ""}
gem "coffee-rails"#{install_devise ? "\ngem \"devise\"" : ""}
gem "ember-rails"
gem "ember-source"
gem "jquery-rails"
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
# Create the Database
# =================================================================

create_database = ask("Do you want to create the database? [yes]")
unless create_database.downcase.include?("n")
  rake "db:create"
end

# =================================================================
# Initialize Git
# =================================================================

git :init
git add: "."
git commit: "-a -m 'Initial commit'"