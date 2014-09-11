module ImportsStylesheet
  def imports(app_name)
    return <<-IMPORTS
@import "#{app_name.underscore}/bourbon";
@import "variables";
@import "#{app_name.underscore}/neat";
IMPORTS
  end
end
