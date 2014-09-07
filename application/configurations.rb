Dir["#{File.dirname(__FILE__)}/configurations/*.rb"].each {|file| require file }

class Configurations
  extend DatabaseConfig
  extend DevelopmentConfig
  extend DeviseConfig
  extend EnvConfig
  extend GemfileConfig
  extend GitignoreConfig
  extend GuardfileConfig
  extend JshintConfig
  extend ProcfileConfig
  extend ProductionConfig
  extend RoutesConfig
  extend RspecConfig
  extend SmtpConfig
  extend TmPropertiesConfig
end
