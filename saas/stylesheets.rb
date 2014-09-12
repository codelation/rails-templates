module Saas
  class Stylesheets < ::Stylesheets

    def self.contact_messages_main
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/contact_messages/main.scss")
    end

    def self.home(app_name)
      return <<-APPLICATION
/*
 *= require #{app_name.underscore}/font-awesome
 *= require #{app_name.underscore}/normalize
 *= require_tree ./shared
 *= require_tree ./home
 *= require_self
 */
APPLICATION
    end

    def self.home_contact
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/contact.scss")
    end

    def self.home_footer
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/layout/_footer.scss")
    end

    def self.home_header
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/layout/_header.scss")
    end
  end
end
