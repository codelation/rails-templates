class OmniAuthProvidersController < ApplicationController

  def index
    @title = "Connected Accounts ~ #{@subscriber.display_name}"
  end

  def destroy
    @omni_auth_provider = OmniAuthProvider.find(params[:id])
    @omni_auth_provider.destroy
    redirect_to subscriber_omni_auth_providers_path, notice: "Account disconnected successfully."
  end

end
