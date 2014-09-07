module ApplicationJavascript
  def application
    File.read("#{File.dirname(__FILE__)}/application.js")
  end
end
