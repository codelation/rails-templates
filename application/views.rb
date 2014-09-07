Dir["#{File.dirname(__FILE__)}/views/*.rb"].each {|file| require file }

class Views
  extend AnalyticsView
  extend ApplicationView
  extend DeviseViews
  extend FlashMessagesView
  extend FooterView
  extend HeaderView
end
