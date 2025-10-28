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
      app.config.assets.paths << root.join('app/assets')
    end

    initializer 'rails8_boilerplate.helpers' do
      ActiveSupport.on_load(:action_controller_base) do
        helper Rails8Boilerplate::Engine.helpers
      end
    end

    config.generators.templates.unshift File.expand_path('../../../lib/generators', __dir__)
  end
end
