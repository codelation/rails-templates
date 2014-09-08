module FontAwesomeStylesheets
  def font_awesome
    File.read("#{File.dirname(__FILE__)}/font-awesome.scss")
  end

  def font_awesome_zip
    File.read("#{File.dirname(__FILE__)}/font-awesome.zip")
  end
end
