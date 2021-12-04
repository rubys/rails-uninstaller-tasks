say "Remove Turbo Import"
gsub_file "app/javascript/application.js", %(import "@hotwired/turbo-rails"\n), ''

say "Unpin Turbo"
gsub_file "config/importmap.rb", /^pin "@hotwired\/turbo-rails", .*\n/, ''
