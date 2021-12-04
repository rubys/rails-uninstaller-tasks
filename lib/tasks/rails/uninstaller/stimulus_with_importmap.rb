if File.exist? "app/javascript/controllers/index.js"
  say "Remove index from controllers directory"
  remove_file "app/javascript/controllers/index.js"
end

say "Remove import of Stimulus controllers"
gsub_file "app/javascript/application.js", %(import "controllers"\n), ''

say "Unpin Stimulus"
gsub_file "config/importmap.rb",
  /^pin "@hotwired\/stimulus", .*\n/, ''
gsub_file "config/importmap.rb",
  /^pin "@hotwired\/stimulus-loading", .*\n/, ''
gsub_file "config/importmap.rb",
  /^pin_all_from "app\/javascript\/controllers", .*\n/, ''
