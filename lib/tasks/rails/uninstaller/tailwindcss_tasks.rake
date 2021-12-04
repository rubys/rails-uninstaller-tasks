# to be inserted into https://github.com/rails/tailwindcss-rails/blob/main/lib/tasks/tailwindcss_tasks.rake

namespace :tailwindcss do
  desc "Remove Tailwind CSS from the app"
  task :uninstall do
    system "#{RbConfig.ruby} ./bin/rails app:template LOCATION=#{File.expand_path("./tailwindcss.rb", __dir__)}"
  end
end
