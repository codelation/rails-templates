Dir["#{File.dirname(__FILE__)}/stylesheets/*.rb"].each {|file| require file }

class Stylesheets
  extend ApplicationStylesheet
  extend BodyStylesheet
  extend ButtonsStylesheet
  extend DeviseStylesheet
  extend FlashMessagesStylesheet
  extend FormsStylesheet
  extend HeadingsStylesheet
  extend ImportsStylesheet
  extend ListsStylesheet
  extend NormalizeStylesheet
  extend VariablesStylesheet
end
