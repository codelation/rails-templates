module Saas
  class Concerns

    def self.subscriber
      File.read("#{File.dirname(__FILE__)}/concerns/subscriber.rb")
    end

    def self.subscriber_spec
      File.read("#{File.dirname(__FILE__)}/spec/concerns/subscriber_spec.rb")
    end

  end
end
