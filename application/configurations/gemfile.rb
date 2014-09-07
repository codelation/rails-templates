module GemfileConfig
  def gemfile(install_blogelator, install_devise)
    return <<-GEMFILE
source "http://rubygems.org"

ruby "2.1.2"
gem "rails", "4.1.5"

gem "awesome_print"#{install_blogelator ? "\ngem \"blogelator\"" : ""}#{install_devise ? "\ngem \"cancan\"" : ""}
gem "coffee-rails"#{install_devise ? "\ngem \"devise\"" : ""}
gem "ember-rails"
gem "ember-source"
gem "jbuilder"
gem "jquery-rails"
gem "local_time"
gem "pg"
gem "puma"
gem "roadie"
gem "roadie-rails"
gem "sass-rails"
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
end
