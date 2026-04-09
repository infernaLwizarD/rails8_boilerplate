require 'devise'
require 'discard'
require 'morph'
require 'pagy'
require 'pundit'
require 'ransack'
require 'colorize'

module Rails8Boilerplate
  class Engine < ::Rails::Engine
    isolate_namespace Rails8Boilerplate

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot
      g.factory_bot dir: 'spec/factories'
    end

    config.autoload_paths << File.expand_path('../../../app/models/concerns', __dir__)
    config.autoload_paths << File.expand_path('../../../app/controllers/concerns', __dir__)
    
    initializer 'rails8_boilerplate.assets' do |app|
      app.config.assets.paths << root.join('app/assets/stylesheets')
      app.config.assets.paths << root.join('app/assets/images')
      app.config.assets.paths << root.join('app/javascript')
    end

    initializer 'rails8_boilerplate.helpers' do
      engine_helpers = root.join('app/helpers')

      ActiveSupport.on_load(:action_controller_base) do
        # Загружаем хелперы из engine: для ApplicationHelper — дополняет существующий
        # модуль хост-приложения методами engine (ts_link_to и др.),
        # для остальных (ButtonsHelper, CommonHelper и т.д.) — создаёт модули
        Dir[engine_helpers.join('*.rb')].sort.each { |f| require f }

        helper ::ButtonsHelper
        helper ::CommonHelper
        helper ::FontAwesomeHelper
        helper ::PagyHelper
        helper ::RansackHelper
      end
    end

    initializer 'rails8_boilerplate.importmap', before: 'importmap' do |app|
      app.config.importmap.paths << root.join('config/importmap.rb')
    end

    config.generators.templates.unshift File.expand_path('../../../lib/generators', __dir__)
  end
end
