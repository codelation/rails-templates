class UserAccount::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :set_body_class

private

  def set_body_class
    @body_class = "user-account"
  end
end
