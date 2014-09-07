module TmPropertiesConfig
  def tm_properties
    File.read("#{File.dirname(__FILE__)}/../../.tm_properties")
  end
end
