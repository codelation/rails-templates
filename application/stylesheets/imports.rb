module ImportsStylesheet
  def imports
    File.read("#{File.dirname(__FILE__)}/imports.scss")
  end
end
