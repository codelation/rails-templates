class User < ActiveRecord::Base
  include Subscriber

  # Devise Modules
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Relationships
  has_many :owned_organizations, class_name: "Organization", foreign_key: :owner_id
  has_many :organization_memberships

  # Returns whether or not the user can perform
  # an action on a subject based on roles/permissions.
  # @param action [Symbol]
  # @param subject [Object]
  def can?(action, subject, *args)
    ability = Ability.new(self)
    ability.can?(action, subject, *args)
  end

  # Returns a Time-like class with the user's selected time zone.
  # @return [ActiveSupport::TimeWithZone]
  def time
    Time.zone = self.time_zone
    Time.zone
  end

end
