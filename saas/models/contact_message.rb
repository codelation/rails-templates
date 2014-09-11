class ContactMessage < ActiveRecord::Base
  # Validations
  validates_presence_of :email, :name, :message

  # Callbacks
  after_create :deliver_email

private

  def deliver_email
    ContactMessageMailer.contact_email(self).deliver
  end
end
