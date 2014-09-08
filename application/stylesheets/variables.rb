module VariablesStylesheet
  def variables
    File.read("#{File.dirname(__FILE__)}/variables.scss")
  end
end
