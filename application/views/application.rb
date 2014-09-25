module ApplicationView
  def layouts_application
    File.read("#{File.dirname(__FILE__)}/layouts/application.html.erb")
  end
end
