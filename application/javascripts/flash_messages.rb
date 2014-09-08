module FlashMessagesJavascript
  def flash_messages
    File.read("#{File.dirname(__FILE__)}/flash_messages.js")
  end
end
