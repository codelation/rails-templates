module EnvConfig
  def env
    return <<-ENV
DEVISE_SECRET_TOKEN=#{SecureRandom.hex(64)}
HOSTNAME=localhost:3000
ENV
  end
end
