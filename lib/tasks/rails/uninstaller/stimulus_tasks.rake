# to be inserted into https://github.com/hotwired/stimulus-rails/blob/main/lib/tasks/stimulus_tasks.rake

require "stimulus/manifest"

def run_stimulus_uninstall_template(path) system "#{RbConfig.ruby} ./bin/rails app:template LOCATION=#{File.expand_path("./#{path}.rb",  __dir__)}" end

namespace :stimulus do
  desc "Uninstall Stimulus from the app"
  task :uninstall do
    if Rails.root.join("config/importmap.rb").exist?
      Rake::Task["stimulus:uninstall:importmap"].invoke
    elsif Rails.root.join("package.json").exist?
      Rake::Task["stimulus:uninstall:node"].invoke
    end
  end

  namespace :uninstall do
    desc "unInstall Stimulus on an app running importmap-rails"
    task :importmap do
      run_stimulus_uninstall_template "stimulus_with_importmap"
    end

    desc "Install Stimulus on an app running node"
    task :node do
      run_stimulus_uninstall_template "stimulus_with_node"
    end
  end
end
