module Rails
  module Uninstaller
    module Tasks
      class Railtie < ::Rails::Railtie
        rake_tasks do
          tasks = File.expand_path('../../../tasks', __dir__)
          Dir.glob("#{tasks}/**/*.rake").each { |f| load f }
        end
      end
    end
  end
end
