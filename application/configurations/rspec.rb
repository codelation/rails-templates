module RspecConfig
  def rspec
    return <<-RSPEC
--color
--require spec_helper
RSPEC
  end
end
