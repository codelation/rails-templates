class OmniAuthProvidersController < ApplicationController

  def index
    @title = "Connected Accounts ~ #{@subscriber.display_name}"
  end

end
