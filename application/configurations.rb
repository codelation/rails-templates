Dir["#{File.dirname(__FILE__)}/configurations/*.rb"].each {|file| require file }

class Configurations
  extend DatabaseConfig
  extend DevelopmentConfig
  extend DeviseConfig
  extend GemfileConfig
  extend JshintConfig
  extend ProductionConfig
  extend RoutesConfig
  extend SmtpConfig
  extend TmPropertiesConfig
end
