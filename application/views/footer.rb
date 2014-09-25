module FooterView
  def layouts_application_footer
    File.read("#{File.dirname(__FILE__)}/layouts/application/_footer.html.erb")
  end
end
