module Saas
  class Helpers < ::Helpers

    def self.application(app_name)
      return <<-APPLICATION
module ApplicationHelper
  include LocalTimeHelper

  def body_class
    body_class = @body_class || "default"
    body_class += " " + controller.controller_name.dasherize
    body_class += " " + controller.action_name.dasherize
    body_class
  end

  def page_title
    page = @title
    if page
      "\#{page} | \#{site_title}"
    else
      site_title
    end
  end

  def site_title
    "#{app_name.titleize}"
  end

  def subscriber_params
    if @organization && @organization.persisted?
      {
        resource_name: "organizations",
        subscriber_id: @organization.id
      }
    elsif current_user && current_user.active_subscription?
      {
        resource_name: "users",
        subscriber_id: current_user.id
      }
    elsif current_user
      if organization = current_user.organizations.find{|organization| organization.active_subscription? }
        {
          resource_name: "organizations",
          subscriber_id: organization.id
        }
      else
        {
          resource_name: "users",
          subscriber_id: current_user.id
        }
      end
    else
      {}
    end
  end

end
APPLICATION
    end

    def self.subscription_plans
      File.read("#{File.dirname(__FILE__)}/helpers/subscription_plans_helper.rb")
    end

  end
end
