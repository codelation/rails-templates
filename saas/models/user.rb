class User < ActiveRecord::Base
  include Subscriber

  # Devise Modules
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Relationships
  has_many :owned_organizations, class_name: "Organization", foreign_key: :owner_id
  has_many :organization_memberships

  # Validations
  validates_presence_of :name, :subscription_plan_id

  # Callbacks
  after_create :set_subscription_plan

  attr_accessor :subscription_plan_id

  # Returns whether or not the user can perform
  # an action on a subject based on roles/permissions.
  # @param action [Symbol]
  # @param subject [Object]
  def can?(action, subject, *args)
    ability = Ability.new(self)
    ability.can?(action, subject, *args)
  end

  # Returns the name to be displayed for the user. The user's name will be
  # returned if it exists and will fall back to the user's email address.
  # @return [String]
  def display_name
    self.name || self.email
  end

  # Returns a Time-like class with the user's selected time zone.
  # @return [ActiveSupport::TimeWithZone]
  def time
    Time.zone = self.time_zone
    Time.zone
  end

private

  # Subscribes the user to the selected subscription plan.
  def set_subscription_plan
    subscription_plan = SubscriptionPlan.find(self.subscription_plan_id)
    self.subscribe_to_plan(subscription_plan)
  end

end
