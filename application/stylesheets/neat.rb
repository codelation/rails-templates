module NeatStylesheets
  def neat
    File.read("#{File.dirname(__FILE__)}/neat.scss")
  end

  def neat_zip
    File.read("#{File.dirname(__FILE__)}/neat.zip")
  end
end
