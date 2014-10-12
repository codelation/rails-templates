module Saas
  class Workers

    def self.refresh_omni_auth_tokens
      File.read("#{File.dirname(__FILE__)}/workers/refresh_omni_auth_tokens_worker.rb")
    end

  end
end
