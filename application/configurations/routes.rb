module RoutesConfig
  def routes(app_class)
    return <<-ROUTES
#{app_class}::Application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/email"
  end
end
ROUTES
  end
end
