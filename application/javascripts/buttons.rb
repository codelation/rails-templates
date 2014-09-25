module ButtonsJavascript
  def buttons
    File.read("#{File.dirname(__FILE__)}/buttons.js")
  end
end
