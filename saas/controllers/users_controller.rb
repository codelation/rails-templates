class UsersController < ApplicationController
  before_action :set_user, :set_subscriber

  def edit
    @title = "My Account"
  end

  def show
    redirect_to edit_user_path(@user)
  end

  def update
    @title = "My Account"

    if user_params.has_key?(:password)
      if @user.update_with_password(user_params)
        sign_in(@user, bypass: true)
        redirect_to edit_user_path(@user), notice: "Password updated successfully."
      else
        render :edit
      end
    else
      if @user.update_without_password(user_params)
        redirect_to edit_user_path(@user), notice: "Account updated successfully."
      else
        render :edit
      end
    end
  end

  def url_options
    { resource_name: "users", subscriber_id: current_user.id }.merge(super)
  end

private

  def set_subscriber
    @subscriber = @user
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :current_password,
      :email,
      :name,
      :password,
      :password_confirmation
    )
  end

end
