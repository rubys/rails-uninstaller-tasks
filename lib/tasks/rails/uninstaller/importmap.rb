APPLICATION_LAYOUT_PATH = Rails.root.join("app/views/layouts/application.html.erb")

if APPLICATION_LAYOUT_PATH.exist?
  say "Remove Importmap include tags from application layout"
  gsub_file APPLICATION_LAYOUT_PATH.to_s, /\s+<%= javascript_importmap_tags %>/, ''
end

if Dir.glob('vendor/javascript').empty?
  say "Remove vendor/javascript for downloaded pins"
  remove_dir "vendor/javascript"
end

if (application_js_path = Rails.root.join("app/javascript/application.js")).exist?
  empty = File.readlines(application_js_path).all? do |line|
    line =~ %r{^\s*(//.*)?$}
  end

  if empty
    say "Remove application.js module as entrypoint"
    remove_file "app/javascript/application.js"
  end
end

if (sprockets_manifest_path = Rails.root.join("app/assets/config/manifest.js")).exist?
  say "Remove JavaScript files from the Sprocket manifest"
  gsub_file sprockets_manifest_path, %(//= link_tree ../../javascript .js\n), ''
  gsub_file sprockets_manifest_path, %(//= link_tree ../../../vendor/javascript .js\n), ''
end

remove_file "config/importmap.rb"

say "Remove binstub"
remove_file "bin/importmap"

