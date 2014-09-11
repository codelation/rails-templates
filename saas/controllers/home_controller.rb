class HomeController < ApplicationController
  layout "home"

  def about
    @title = "About Us"
  end

  def contact
    @contact_message = ContactMessage.new

    @title = "Contact Us"
  end

  def features
    @title = "Features"
  end

  def index
    @title = "Welcome"
  end

  def pricing
    @subscription_plans = SubscriptionPlan.active

    @title = "Pricing"
  end

  def privacy
    @title = "Privacy Policy"
  end

  def terms
    @title = "Terms of Service"
  end
end