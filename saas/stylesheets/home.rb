module HomeStylesheet
  def home(app_name)
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
end
