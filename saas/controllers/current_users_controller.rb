class CurrentUsersController < ApplicationController
  layout "home"

  def edit
    @user = current_user
    @title = "Account Settings"
  end

end
