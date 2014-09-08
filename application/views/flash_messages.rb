module FlashMessagesView
  def flash_messages
    File.read("#{File.dirname(__FILE__)}/flash_messages.html.erb")
  end
end
