Dir["#{File.dirname(__FILE__)}/configurations/*.rb"].each {|file| require file }

class Configurations
  extend DatabaseConfig
  extend DevelopmentConfig
  extend ProductionConfig
  extend SmtpConfig
end
