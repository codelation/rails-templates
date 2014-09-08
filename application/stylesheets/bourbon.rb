module BourbonStylesheets
  def bourbon
    File.read("#{File.dirname(__FILE__)}/bourbon.scss")
  end

  def bourbon_zip
    File.read("#{File.dirname(__FILE__)}/bourbon.zip")
  end
end
