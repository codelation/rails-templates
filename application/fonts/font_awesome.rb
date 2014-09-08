module FontAwesomeFonts
  def font_awesome_zip
    File.read("#{File.dirname(__FILE__)}/font-awesome.zip")
  end
end
