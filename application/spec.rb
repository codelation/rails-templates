class Spec
  def self.rails_helper
    File.read("#{File.dirname(__FILE__)}/spec/rails_helper.rb")
  end

  def self.spec_helper
    File.read("#{File.dirname(__FILE__)}/spec/spec_helper.rb")
  end
end
