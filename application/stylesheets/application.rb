module ApplicationStylesheet
  def application
    File.read("#{File.dirname(__FILE__)}/application.scss")
  end
end
