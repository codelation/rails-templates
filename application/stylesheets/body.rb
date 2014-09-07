module BodyStylesheet
  def body
    File.read("#{File.dirname(__FILE__)}/body.scss")
  end
end
