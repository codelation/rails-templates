class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_subscriber

private

  def set_subscriber
    if subscriber_route?
      @subscriber = params[:resource_name].classify.constantize.find(params[:subscriber_id])
    else
      @subscriber = current_user
    end
  end

  def subscriber_route?
    params[:resource_name] && params[:subscriber_id]
  end
end
