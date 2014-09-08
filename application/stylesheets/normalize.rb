module NormalizeStylesheet
  def normalize
    File.read("#{File.dirname(__FILE__)}/normalize.css")
  end
end
