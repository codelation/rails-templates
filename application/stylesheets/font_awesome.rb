module FontAwesomeStylesheets
  def font_awesome
    File.read("#{File.dirname(__FILE__)}/font-awesome.scss")
  end

  def font_awesome_sprockets(app_name)
    return <<-FONTAWESOMESPROCKETS
@function icon-font-path($path) {
  @return font-path('#{app_name.underscore}/' + $path);
}

@function icon-image-path($path) {
  @return image-path('#{app_name.underscore}/' + $path);
}
FONTAWESOMESPROCKETS
  end

  def font_awesome_zip
    File.read("#{File.dirname(__FILE__)}/font-awesome.zip")
  end
end
