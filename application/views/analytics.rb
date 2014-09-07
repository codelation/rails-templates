module AnalyticsView
  def analytics
    File.read("#{File.dirname(__FILE__)}/analytics.html.erb")
  end
end
