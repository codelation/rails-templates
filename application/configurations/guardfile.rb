module GuardfileConfig
  def guardfile
    File.read("#{File.dirname(__FILE__)}/Guardfile")
  end
end
