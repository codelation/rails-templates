module HeaderView
  def layouts_application_header(app_name)
    return <<-HEADER
<header>
  <div class="branding">
    <%= link_to "#{app_name.titleize}", root_path %>
  </div>
</header>
HEADER
  end
end
