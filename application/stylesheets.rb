class Stylesheets
  def self.application(app_name)
    return <<-APPLICATION
/*
 *= require #{app_name.underscore}/font-awesome
 *= require #{app_name.underscore}/normalize
 *= require_tree ./shared
 *= require_tree ./application
 *= require_self
 */
APPLICATION
  end

  def self.imports(app_name)
    return <<-IMPORTS
@import "#{app_name.underscore}/bourbon";
@import "variables";
@import "#{app_name.underscore}/neat";
@import "mixins/button";
IMPORTS
  end

  def self.mixins_button
    File.read("#{File.dirname(__FILE__)}/stylesheets/mixins/button.scss")
  end

  def self.shared_body
    File.read("#{File.dirname(__FILE__)}/stylesheets/shared/body.scss")
  end

  def self.shared_buttons
    File.read("#{File.dirname(__FILE__)}/stylesheets/shared/buttons.scss")
  end

  def self.shared_devise
    File.read("#{File.dirname(__FILE__)}/stylesheets/shared/devise.scss")
  end

  def self.shared_flash_messages
    File.read("#{File.dirname(__FILE__)}/stylesheets/shared/flash_messages.scss")
  end

  def self.shared_forms
    File.read("#{File.dirname(__FILE__)}/stylesheets/shared/forms.scss")
  end

  def self.shared_headings
    File.read("#{File.dirname(__FILE__)}/stylesheets/shared/headings.scss")
  end

  def self.shared_lists
    File.read("#{File.dirname(__FILE__)}/stylesheets/shared/lists.scss")
  end

  def self.variables
    File.read("#{File.dirname(__FILE__)}/stylesheets/_variables.scss")
  end

  def self.vendor_bourbon
    File.read("#{File.dirname(__FILE__)}/stylesheets/vendor/_bourbon.scss")
  end

  def self.vendor_bourbon_zip
    File.read("#{File.dirname(__FILE__)}/stylesheets/vendor/bourbon.zip")
  end

  def self.vendor_font_awesome
    File.read("#{File.dirname(__FILE__)}/stylesheets/vendor/font-awesome.scss")
  end

  def self.vendor_font_awesome_sprockets(app_name)
    return <<-FONTAWESOMESPROCKETS
@function icon-font-path($path) {
  @return font-path('#{app_name.underscore}/' + $path);
}

@function icon-image-path($path) {
  @return image-path('#{app_name.underscore}/' + $path);
}
FONTAWESOMESPROCKETS
  end

  def self.vendor_font_awesome_zip
    File.read("#{File.dirname(__FILE__)}/stylesheets/vendor/font-awesome.zip")
  end

  def self.vendor_neat
    File.read("#{File.dirname(__FILE__)}/stylesheets/vendor/_neat.scss")
  end

  def self.vendor_neat_zip
    File.read("#{File.dirname(__FILE__)}/stylesheets/vendor/neat.zip")
  end

  def self.vendor_normalize
    File.read("#{File.dirname(__FILE__)}/stylesheets/vendor/normalize.css")
  end
end
