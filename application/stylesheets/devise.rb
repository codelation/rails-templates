module DeviseStylesheet
  def devise
    File.read("#{File.dirname(__FILE__)}/devise.scss")
  end
end
