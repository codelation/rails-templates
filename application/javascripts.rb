Dir["#{File.dirname(__FILE__)}/javascripts/*.rb"].each {|file| require file }

class Javascripts
  extend ApplicationJavascript
  extend FlashMessagesJavascript
end
