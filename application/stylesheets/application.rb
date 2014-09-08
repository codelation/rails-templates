module ApplicationStylesheet
  def application(app_name)
    return <<-APPLICATION
/*
 *= require #{app_name}/font-awesome
 *= require #{app_name}/normalize
 *= require_tree ./shared
 *= require_tree ./application
 *= require_self
 */
APPLICATION
  end
end
