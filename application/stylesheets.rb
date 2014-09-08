Dir["#{File.dirname(__FILE__)}/stylesheets/*.rb"].each {|file| require file }

class Stylesheets
  extend ApplicationStylesheet
  extend BodyStylesheet
  extend BourbonStylesheets
  extend ButtonsStylesheet
  extend DeviseStylesheet
  extend FlashMessagesStylesheet
  extend FontAwesomeStylesheets
  extend FormsStylesheet
  extend HeadingsStylesheet
  extend ImportsStylesheet
  extend ListsStylesheet
  extend NeatStylesheets
  extend NormalizeStylesheet
  extend VariablesStylesheet
end
