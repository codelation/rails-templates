module ApplicationView
  def application
    File.read("#{File.dirname(__FILE__)}/application.html.erb")
  end
end
