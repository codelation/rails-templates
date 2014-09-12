class ContactMessagesController < ApplicationController
  layout "home"

  def create
    @contact_message = ContactMessage.new(contact_message_params)

    if @contact_message.save
      redirect_to @contact_message
    else
      render :new
    end
  end

  def new
    @contact_message = ContactMessage.new

    @title = "Contact Us"
  end

  def show

  end

private

  def contact_message_params
    params.require(:contact_message).permit(
      :email,
      :message,
      :name,
      :phone_number
    )
  end

end
