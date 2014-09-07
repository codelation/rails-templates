module HeaderView
  def header(app_name)
    return <<-HEADER
<header>
  <%= link_to "#{app_name.titleize}", root_path %>
</header>
HEADER
  end
end
