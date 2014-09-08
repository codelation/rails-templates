module ListsStylesheet
  def lists
    File.read("#{File.dirname(__FILE__)}/lists.scss")
  end
end
