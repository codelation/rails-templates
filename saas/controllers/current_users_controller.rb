class CurrentUsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
    @title = "Account Settings"
  end

  def update
    @user = current_user

    if @user.update_attributes(user_params)
      redirect_to edit_current_user_path, notice: "Account updated successfully"
    else
      @title = "Account Settings"
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit(
      :email,
      :name,
      :old_password,
      :password,
      :password_confirmation
    )
  end

end
