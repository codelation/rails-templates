module RoutesConfig
  def routes(app_class, install_blocky, install_blogelator)
    return <<-ROUTES
#{app_class}::Application.routes.draw do
#{install_blocky ? "\n  mount Blocky::Engine, at: \"/admin/content\"" : ""}#{install_blogelator ? "\n  mount Blogelator::Engine, at: \"/blog\"" : ""}
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/email"
  end
end
ROUTES
  end
end
