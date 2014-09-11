module DeviseViews
  def devise_confirmations_new
    File.read("#{File.dirname(__FILE__)}/devise/confirmations/new.html.erb")
  end

  def devise_passwords_edit
    File.read("#{File.dirname(__FILE__)}/devise/passwords/edit.html.erb")
  end

  def devise_passwords_new
    File.read("#{File.dirname(__FILE__)}/devise/passwords/new.html.erb")
  end

  def devise_registrations_new
    File.read("#{File.dirname(__FILE__)}/devise/registrations/new.html.erb")
  end

  def devise_sessions_new
    File.read("#{File.dirname(__FILE__)}/devise/sessions/new.html.erb")
  end

  def devise_unlocks_new
    File.read("#{File.dirname(__FILE__)}/devise/unlocks/new.html.erb")
  end
end
