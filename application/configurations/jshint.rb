module JshintConfig
  def jshint
    File.read("#{File.dirname(__FILE__)}/jshint.json")
  end
end
