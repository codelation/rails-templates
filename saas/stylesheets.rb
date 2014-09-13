module Saas
  class Stylesheets < ::Stylesheets

    def self.contact_messages_main
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/contact_messages/main.scss")
    end

    def self.flash_messages
      File.read("#{File.dirname(__FILE__)}/stylesheets/flash_messages.scss")
    end

    def self.home(app_name)
      return <<-HOME
/*
 *= require pied_piper/font-awesome
 *= require pied_piper/normalize
 *= require_tree ./shared
 *= require_tree ./home
 *= require_self
 */

@import url(http://fonts.googleapis.com/css?family=Ovo|Questrial);
HOME
    end

    def self.home_features
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/home/features.scss")
    end

    def self.home_fonts
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/layout/fonts.scss")
    end

    def self.home_footer
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/layout/_footer.scss")
    end

    def self.home_header
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/layout/_header.scss")
    end

    def self.home_index
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/home/index.scss")
    end

    def self.home_index_header
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/home/index/header.scss")
    end

    def self.home_index_sign_up
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/home/index/sign_up.scss")
    end

    def self.home_privacy
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/home/privacy.scss")
    end

    def self.home_terms
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/home/terms.scss")
    end

    def self.home_title
      File.read("#{File.dirname(__FILE__)}/stylesheets/home/layout/title.scss")
    end
  end
end
