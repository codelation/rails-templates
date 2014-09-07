module DatabaseConfig
  def database(app_name)
    return <<-DATABASE
development:
  adapter: postgresql
  database: #{app_name.underscore}_development
  host: localhost

test:
  adapter: postgresql
  database: #{app_name.underscore}_test
  host: localhost

production:
  adapter: postgresql
  database: #{app_name.underscore}_production
  host: localhost
DATABASE
  end
end
