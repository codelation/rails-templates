module AnalyticsView
  def layouts_shared_analytics
    File.read("#{File.dirname(__FILE__)}/layouts/shared/_analytics.html.erb")
  end
end
