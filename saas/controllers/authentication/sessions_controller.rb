module Authentication
  class SessionsController < Devise::SessionsController
    layout "home"
  end
end
