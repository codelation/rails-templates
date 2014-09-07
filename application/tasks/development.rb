module DevelopmentTasks
  def development
    File.read("#{File.dirname(__FILE__)}/development.rake")
  end
end
