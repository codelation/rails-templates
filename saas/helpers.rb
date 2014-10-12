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
      if params[:resource_name] && params[:subscriber_id]
        {
          resource_name: params[:resource_name],
          subscriber_id: params[:subscriber_id]
        }
      elsif @organization
        {
          resource_name: "organizations",
          subscriber_id: @organization.id
        }
      elsif current_user
        {
          resource_name: "users",
          subscriber_id: current_user.id
        }
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
