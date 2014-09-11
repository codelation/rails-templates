module ApplicationView
  def application
    File.read("#{File.dirname(__FILE__)}/layouts/application.html.erb")
  end
end
