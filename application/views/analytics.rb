module AnalyticsView
  def analytics
    File.read("#{File.dirname(__FILE__)}/layouts/shared/_analytics.html.erb")
  end
end
