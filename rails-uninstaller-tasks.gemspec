require_relative "lib/rails/uninstaller/tasks/version"

Gem::Specification.new do |spec|
  spec.name        = "rails-uninstaller-tasks"
  spec.version     = Rails::Uninstaller::Tasks::VERSION
  spec.authors     = ["Sam Ruby"]
  spec.email       = ["rubys@intertwingly.net"]
  spec.homepage    = "https://github.com/rubys/rails-uninstaller-tasks"
  spec.summary     = "Proof of concept uninstaller tasks for Rails."
  spec.description = "Support for changing from import maps to node based bundling."
  spec.license     = "MIT"
  
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", "~> 7.0.0.alpha2"
end
