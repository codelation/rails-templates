class OmniAuthProvidersController < ApplicationController

  def create
    @omni_auth_provider = OmniAuthProvider.new(omni_auth_provider_params)
    @omni_auth_provider.subscriber = current_user

    if @omni_auth_provider.save
      redirect_to subscriber_omni_auth_providers_path(
        resource_name: "users",
        subscriber_id: current_user.id
      ), notice: "Account connected successfully."
    else
      render @omni_auth_provider.name
    end
  end

  def destroy
    @omni_auth_provider = OmniAuthProvider.find(params[:id])
    @omni_auth_provider.destroy
    redirect_to subscriber_omni_auth_providers_path(
      resource_name: "users",
      subscriber_id: current_user.id
    ), notice: "Account disconnected successfully."
  end

  def index
    @title = "Connected Accounts ~ #{@subscriber.display_name}"
  end

  def new
    @omni_auth_provider = OmniAuthProvider.new(name: params[:provider])
    render params[:provider]
  end

private

  def omni_auth_provider_params
    params.require(:omni_auth_provider).permit(
      :access_token,
      :name
    )
  end
end
