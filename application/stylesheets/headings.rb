module HeadingsStylesheet
  def headings
    File.read("#{File.dirname(__FILE__)}/headings.scss")
  end
end
