class CurrentUsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
    @title = "Account Settings"
  end

end
