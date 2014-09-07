module FlashMessagesStylesheet
  def flash_messages
    File.read("#{File.dirname(__FILE__)}/flash_messages.scss")
  end
end
