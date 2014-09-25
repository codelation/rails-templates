module Admin
  class SessionsController < Devise::SessionsController
    layout "home"

    def create
      @title = "Sign In"
      super
    end

    def new
      @title = "Sign In"
      super
    end
  end
end
