module ButtonsStylesheet
  def buttons
    File.read("#{File.dirname(__FILE__)}/buttons.scss")
  end
end
