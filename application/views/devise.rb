module DeviseViews
  def devise_confirmations_new
    File.read("#{File.dirname(__FILE__)}/devise_confirmations_new.html.erb")
  end

  def devise_passwords_edit
    File.read("#{File.dirname(__FILE__)}/devise_passwords_edit.html.erb")
  end

  def devise_passwords_new
    File.read("#{File.dirname(__FILE__)}/devise_passwords_new.html.erb")
  end

  def devise_registrations_new
    File.read("#{File.dirname(__FILE__)}/devise_registrations_new.html.erb")
  end

  def devise_sessions_new
    File.read("#{File.dirname(__FILE__)}/devise_sessions_new.html.erb")
  end

  def devise_unlocks_new
    File.read("#{File.dirname(__FILE__)}/devise_unlocks_new.html.erb")
  end
end
