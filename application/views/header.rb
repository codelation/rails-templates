module HeaderView
  def header(app_name)
    return <<-HEADER
<header>
  <div class="branding">
    <%= link_to "#{app_name.titleize}", root_path %>
  </div>
</header>
HEADER
  end
end
