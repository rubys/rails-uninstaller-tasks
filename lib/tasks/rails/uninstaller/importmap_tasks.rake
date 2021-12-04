namespace :importmap do
  desc "Remore Importmap from the app"
  task :uninstall do
    system "#{RbConfig.ruby} ./bin/rails app:template LOCATION=#{File.expand_path("./importmap.rb",  __dir__)}"
  end
end
