Dir["#{File.dirname(__FILE__)}/fonts/*.rb"].each {|file| require file }

class Fonts
  extend FontAwesomeFonts
end
