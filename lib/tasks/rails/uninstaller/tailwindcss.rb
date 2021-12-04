APPLICATION_LAYOUT_PATH = Rails.root.join("app/views/layouts/application.html.erb")

if APPLICATION_LAYOUT_PATH.exist?
  say "Remove Tailwindcss include tags from application layout"
  gsub_file APPLICATION_LAYOUT_PATH.to_s,
    /^\s*<%= stylesheet_link_tag "inter-font".*\n\n?/, "\n"
  gsub_file APPLICATION_LAYOUT_PATH.to_s,
    /^\s*<%= stylesheet_link_tag "tailwind".*\n\n?/, "\n"
end

say "Turn off purging of unused css classes in production"
gsub_file Rails.root.join("config/environments/production.rb"),
   /(^\s+)(config.assets.css_compressor = :purger)/, "\\1# \\2"
