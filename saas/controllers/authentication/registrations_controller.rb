module Authentication
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters
    layout "home"

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:name, :subscription_plan_id]
    end
  end
end
