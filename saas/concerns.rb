module Saas
  class Concerns

    def self.omni_auth_provider_clients
      File.read("#{File.dirname(__FILE__)}/concerns/omni_auth_provider_clients.rb")
    end

  end
end
