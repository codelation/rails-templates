module Saas
  class Jobs

    def self.refresh_omni_auth_tokens
      File.read("#{File.dirname(__FILE__)}/jobs/refresh_omni_auth_tokens_job.rb")
    end

  end
end
