module FlashMessagesView
  def layouts_shared_flash_messages
    File.read("#{File.dirname(__FILE__)}/layouts/shared/_flash_messages.html.erb")
  end
end
