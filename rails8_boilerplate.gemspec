require_relative 'lib/rails8_boilerplate/version'

Gem::Specification.new do |spec|
  spec.name        = 'rails8_boilerplate'
  spec.version     = Rails8Boilerplate::VERSION
  spec.authors     = ['Nikita Dolgopolov']
  spec.email       = ['nikita.dolgopolov@gmail.com']
  spec.homepage    = 'https://github.com/infernaLwizarD/rails8_boilerplate'
  spec.summary     = 'Boilerplate для быстрого старта Rails 8 приложений'
  spec.description = 'Полнофункциональный Rails 8 Engine с Devise, AdminLTE 4, Pundit, Ransack, Discard, генератором CRUD и готовыми компонентами для мгновенного старта проектов'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib,spec}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.required_ruby_version = '>= 3.3.0'

  spec.add_dependency 'rails', '~> 8.1.2'
  spec.add_dependency 'devise', '~> 4.9'
  spec.add_dependency 'discard', '~> 1.4'
  spec.add_dependency 'csv'
  spec.add_dependency 'morph', '~> 0.3'
  spec.add_dependency 'pagy', '~> 9.4'
  spec.add_dependency 'pundit', '~> 2.3'
  spec.add_dependency 'ransack', '~> 4.2'
  spec.add_dependency 'colorize', '~> 1.1'
  
  spec.add_development_dependency 'factory_bot_rails', '~> 6.4'
  spec.add_development_dependency 'faker', '~> 3.5'
  spec.add_development_dependency 'rspec-rails', '~> 8.0'
  spec.add_development_dependency 'capybara', '~> 3.40'
  spec.add_development_dependency 'selenium-webdriver', '~> 4.27'
  spec.add_development_dependency 'webdrivers', '~> 5.3'
  spec.add_development_dependency 'email_spec', '~> 2.2'
  spec.add_development_dependency 'test-prof', '~> 1.4'
  spec.add_development_dependency 'rubocop', '~> 1.69'
  spec.add_development_dependency 'rubocop-rails', '~> 2.27'
  spec.add_development_dependency 'rubocop-rspec', '~> 3.2'
  spec.add_development_dependency 'rubocop-performance', '~> 1.23'
  spec.add_development_dependency 'rubocop-factory_bot', '~> 2.26'
end
