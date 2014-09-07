module FooterView
  def footer
    File.read("#{File.dirname(__FILE__)}/footer.html.erb")
  end
end
