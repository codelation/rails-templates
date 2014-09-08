Dir["#{File.dirname(__FILE__)}/tasks/*.rb"].each {|file| require file }

class Tasks
  extend DevelopmentTasks
end
