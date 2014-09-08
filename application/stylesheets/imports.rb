module ImportsStylesheet
  def imports(app_name)
    return <<-IMPORTS
@import "#{app_name}/bourbon";
@import "variables";
@import "#{app_name}/neat";
IMPORTS
  end
end
