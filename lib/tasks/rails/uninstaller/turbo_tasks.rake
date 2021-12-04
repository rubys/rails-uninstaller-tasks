# to be inserted into https://github.com/hotwired/turbo-rails/blob/main/lib/tasks/turbo_tasks.rake
def run_turbo_uninstall_template(path)
  system "#{RbConfig.ruby} ./bin/rails app:template LOCATION=#{File.expand_path("./#{path}.rb", __dir__)}"
end

namespace :turbo do
  desc "Uninstall Turbo from the app"
  task :uninstall do
    if Rails.root.join("config/importmap.rb").exist?
      Rake::Task["turbo:uninstall:importmap"].invoke
    elsif Rails.root.join("package.json").exist?
      Rake::Task["turbo:uninstall:node"].invoke
    end
  end

  namespace :uninstall do
    desc "Uninstall Turbo from the app with asset pipeline"
    task :importmap do
      run_turbo_uninstall_template "turbo_with_importmap"
    end

    desc "Uninstall Turbo from the app with webpacker"
    task :node do
      run_turbo_uninstall_template "turbo_with_node"
    end
  end
end

