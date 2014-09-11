module FlashMessagesView
  def flash_messages
    File.read("#{File.dirname(__FILE__)}/layouts/shared/_flash_messages.html.erb")
  end
end
