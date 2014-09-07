module FormsStylesheet
  def forms
    File.read("#{File.dirname(__FILE__)}/forms.scss")
  end
end
