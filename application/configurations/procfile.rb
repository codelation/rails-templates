module ProcfileConfig
  def procfile
    File.read("#{File.dirname(__FILE__)}/Procfile")
  end

  def procfile_development
    File.read("#{File.dirname(__FILE__)}/Procfile.development")
  end
end
