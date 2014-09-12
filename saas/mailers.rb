module Saas
  class Mailers

    def self.contact_message(app_name)
      return <<-CONTACTMESSAGE
class ContactMessageMailer < ActionMailer::Base
  default from: ENV["CONTACT_EMAIL_ADDRESS"]

  def contact_email(contact_message)
    @contact_message = contact_message
    mail(
      to:      ENV["CONTACT_EMAIL_ADDRESS"],
      from:    contact_message.email,
      subject: "[#{app_name.titleize}] New Contact Form Submission"
    )
  end
end
CONTACTMESSAGE
    end

  end
end
