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

importmap = IO.read Rails.root.join("config/importmap.rb")
importmap.sub! /\n\s*pin "application".*/, "\n"
remove_file "config/importmap.rb"
empty = importmap.split("\n").all? do |line|
  line =~ %r{^\s*(#.*)?$}
end
importmap.sub! /\A# Pin npm.*\n/, ''
importmap.sub! /\A/, "# Review the following for potential additions to package.json\n"
create_file "config/importmap.REVIEWME", importmap unless empty

say "Remove binstub"
remove_file "bin/importmap"

