require 'rails/generators'
require 'rails/generators/migration'

module Rails8Boilerplate
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root Rails8Boilerplate::Engine.root

      desc 'Установка Rails8Boilerplate в ваше приложение'

      class_option :no_kamal, type: :boolean, default: false, desc: 'Пропустить установку Kamal конфигурации'
      class_option :no_docker, type: :boolean, default: false, desc: 'Пропустить установку Docker конфигурации'
      class_option :main_branch, type: :string, default: 'main', desc: 'Главная ветка проекта (main/master)'
      class_option :force, type: :boolean, default: false, desc: 'Перезаписать существующие файлы без запроса подтверждения'

      def copy_migrations
        # Копируем миграцию Devise для создания таблицы users
        migration_template 'db/migrate/devise_create_users.rb',
                          'db/migrate/devise_create_users.rb',
                          migration_version: migration_version
      end

      def copy_initializers
        say "Копирование initializers...", :green
        template 'lib/generators/rails8_boilerplate/templates/initializers/devise.rb',
                 'config/initializers/devise.rb', force: options[:force]
        template 'lib/generators/rails8_boilerplate/templates/initializers/pagy.rb',
                 'config/initializers/pagy.rb', force: options[:force]

        say "\n⚠️ Настройте initializers под ваше приложение при необходимости:", :yellow
        say "  - config/initializers/devise.rb"
        say "  - config/initializers/pagy.rb\n"
      end

      def copy_models
        say "Копирование моделей...", :green
        directory 'lib/generators/rails8_boilerplate/templates/models', 'app/models', force: options[:force]
      end

      def copy_repositories
        say "Копирование репозиториев...", :green
        directory 'lib/generators/rails8_boilerplate/templates/repositories', 'app/repositories', force: options[:force]
      end

      def copy_controllers
        say "Копирование контроллеров...", :green
        directory 'lib/generators/rails8_boilerplate/templates/controllers/web', 'app/controllers/web', force: options[:force]
      end

      def copy_policies
        say "Копирование политик...", :green
        directory 'lib/generators/rails8_boilerplate/templates/policies', 'app/policies', force: options[:force]
      end

      def copy_views
        say "Копирование вью...", :green
        directory 'lib/generators/rails8_boilerplate/templates/views/web', 'app/views/web', force: options[:force]
        # Layouts остаются в engine (AdminLTE шаблоны)
      end

      def remove_default_layout
        say "Удаление стандартного layout хост-приложения...", :green
        # Стандартный layouts/application.html.erb перекрывает layout engine,
        # в котором подключены header, footer, sidebar и CSS
        layout_file = 'app/views/layouts/application.html.erb'
        if File.exist?(layout_file)
          remove_file layout_file
          say "  ✓ #{layout_file} удалён (используется layout из engine)", :green
        end
      end

      def configure_application_controller
        say "Настройка ApplicationController...", :green

        inject_into_class 'app/controllers/application_controller.rb',
                          'ApplicationController',
                          "  include Pundit::Authorization\n  include Pagy::Backend\n\n"

        say "  ✓ Добавлены Pundit::Authorization и Pagy::Backend", :green
      end

      def copy_specs
        say "Копирование тестов...", :green
        directory 'lib/generators/rails8_boilerplate/templates/spec', 'spec', force: options[:force]
      end

      def copy_locales
        say "Копирование локализаций...", :green
        directory 'config/locales', 'config/locales', force: options[:force]
      end

      def copy_seeds
        say "Копирование seeds...", :green
        copy_file 'db/seeds.rb', 'db/seeds.rb', force: options[:force]
      end

      def copy_rubocop_config
        say "Копирование RuboCop конфигурации...", :green

        if File.exist?('.rubocop.yml') && !options[:force]
          # Если файл существует и не установлен force, копируем как .sample
          copy_file 'lib/generators/rails8_boilerplate/templates/rubocop.yml', '.rubocop.yml.sample'
          say "  ✓ .rubocop.yml.sample (оригинал уже существует)", :yellow
          
          say "\n⚠️ .rubocop.yml уже существует:", :yellow
          say "  - Проверьте .rubocop.yml.sample и при необходимости объедините правила\n"
        else
          # Если файла нет или установлен force, копируем как есть
          copy_file 'lib/generators/rails8_boilerplate/templates/rubocop.yml', '.rubocop.yml', force: options[:force]
          say "  ✓ .rubocop.yml", :green
          
          say "\n⚠️  RuboCop конфигурация скопирована", :yellow
          say "  - Проверьте настройки и адаптируйте под ваш проект\n"
        end
      end

      def copy_docker_configs
        return if options[:no_docker]
        
        say "Копирование Docker конфигурации...", :green

        docker_dir = File.join(self.class.source_root, 'lib/generators/rails8_boilerplate/templates/docker')
        
        Dir.glob(File.join(docker_dir, '*')).each do |source_path|
          next unless File.file?(source_path)
          
          file = File.basename(source_path)
          source_file = "lib/generators/rails8_boilerplate/templates/docker/#{file}"
          
          if File.exist?(file) && !options[:force]
            # Если файл существует и не установлен force, копируем как .sample
            copy_file source_file, "#{file}.sample"
            say "  ✓ #{file}.sample (оригинал уже существует)", :yellow
          else
            # Если файла нет или установлен force, копируем как есть
            copy_file source_file, file, force: options[:force]
            say "  ✓ #{file}", :green
          end
        end

        say "\n⚠️ Docker конфигурация скопирована", :yellow
        say "  - Проверьте скопированные файлы и при необходимости объедините с существующими\n"
      end

      def copy_env_sample
        say "Создание .env файла...", :green

        if File.exist?('.env') && !options[:force]
          # Если .env уже существует и не установлен force, создаем только .env.sample
          template 'lib/generators/rails8_boilerplate/templates/env.sample', '.env.sample', force: options[:force]
          say "  ✓ .env.sample создан (файл .env уже существует)", :yellow
          
          say "\n⚠️ .env файл уже существует:", :yellow
          say "  - Проверьте .env.sample и при необходимости обновите ваш .env"
          say "  - Убедитесь, что все необходимые переменные присутствуют\n"
        else
          # Если .env не существует или установлен force, создаем и .env и .env.sample
          template 'lib/generators/rails8_boilerplate/templates/env.sample', '.env', force: options[:force]
          template 'lib/generators/rails8_boilerplate/templates/env.sample', '.env.sample', force: options[:force]
          say "  ✓ .env создан", :green
          say "  ✓ .env.sample создан", :green
          
          say "\n⚠️ Настройте .env файл:", :yellow
          say "  - Проверьте сгенерированные значения RAILS_MASTER_KEY и DB_PASSWORD"
          say "  - Файл .env добавлен в .gitignore (не коммитьте его!)\n"
        end
      end

      def setup_kamal
        return if options[:no_kamal]
        
        say "Настройка Kamal для деплоя...", :green

        # Запускаем kamal init для создания базовой структуры
        run 'kamal init', capture: true

        # Переименовываем сгенерированный secrets в sample
        if File.exist?('.kamal/secrets')
          run 'mv .kamal/secrets .kamal/secrets.sample'
        end

        # Копируем наш кастомный secrets
        copy_file 'lib/generators/rails8_boilerplate/templates/kamal/secrets', '.kamal/secrets', force: options[:force]

        # Переименовываем сгенерированный deploy.yml в sample
        if File.exist?('config/deploy.yml')
          run 'mv config/deploy.yml config/deploy.yml.sample'
        end

        # Копируем наш кастомный deploy.yml
        template 'lib/generators/rails8_boilerplate/templates/kamal/deploy.yml', 'config/deploy.yml', force: options[:force]

        say "\n⚠️ Настройте Kamal конфигурацию:", :yellow
        say "  - .kamal/secrets"
        say "  - config/deploy.yml (измените service, image, servers и т.д.)\n"
      end

      def setup_github_workflows
        say "Настройка GitHub Actions workflows...", :green

        # Устанавливаем переменную для главной ветки
        @main_branch = options[:main_branch]

        # Создаем директорию .github/workflows если её нет
        empty_directory '.github/workflows' unless File.exist?('.github/workflows')

        # Переименовываем существующий ci.yml в sample если он есть и не установлен force
        if File.exist?('.github/workflows/ci.yml') && !options[:force]
          run 'mv .github/workflows/ci.yml .github/workflows/ci.yml.sample'
        end

        # Копируем наш кастомный ci.yml
        template 'lib/generators/rails8_boilerplate/templates/github/workflows/ci.yml', 
                 '.github/workflows/ci.yml', force: options[:force]

        # Копируем deploy workflows как disabled
        template 'lib/generators/rails8_boilerplate/templates/github/workflows/deploy.ghcr.yml.disabled',
                 '.github/workflows/deploy.ghcr.yml.disabled', force: options[:force]
        template 'lib/generators/rails8_boilerplate/templates/github/workflows/deploy.dockerhub.yml.disabled',
                 '.github/workflows/deploy.dockerhub.yml.disabled', force: options[:force]

        say "\n⚠️ Настройте GitHub Actions:", :yellow
        say "  - Главная ветка установлена: #{@main_branch}"
        say "  - Добавьте secrets в GitHub репозиторий (DEPLOY_SSH_KEY, SERVER_IP, и т.д.)"
        say "  - Переименуйте один из deploy.*.yml.disabled в deploy.yml для активации деплоя\n"
      end

      def setup_env_production
        say "Создание .env.production.sample...", :green

        # Копируем .env.production.sample с подстановкой значений
        template 'lib/generators/rails8_boilerplate/templates/env.production.sample',
                 '.env.production.sample', force: options[:force]

        say "\n⚠️ Настройте .env.production.sample:", :yellow
        say "  - Проверьте сгенерированные значения RAILS_MASTER_KEY и DB_PASSWORD"
        say "  - Скопируйте .env.production.sample в .env на production сервер\n"
      end

      def setup_javascript
        say "Настройка JavaScript импортов...", :green

        # Engine автоматически добавляет свои importmap pins через initializer.
        # Здесь добавляем импорты engine-библиотек в application.js хост-приложения.
        js_file = 'app/javascript/application.js'

        unless File.exist?(js_file)
          say "  ⚠️ #{js_file} не найден, пропускаем", :yellow
          return
        end

        imports = <<~JS

          // Rails8Boilerplate
          import "bootstrap"
          import "adminlte"
          import "fontawesome"
          import "fontawesome_solid"
        JS

        content = File.read(js_file)
        unless content.include?('import "bootstrap"')
          append_to_file js_file, imports
          say "  ✓ Добавлены импорты bootstrap, adminlte, fontawesome", :green
        end
      end

      def configure_application
        say "Настройка config/application.rb...", :green

        application_config = <<-RUBY

    config.i18n.default_locale = :ru
    config.active_record.schema_format = :sql
        RUBY

        inject_into_file 'config/application.rb', application_config,
                         after: "config.load_defaults 8.1\n"
      end

      def add_routes
        route_content = <<-RUBY

  # Rails8Boilerplate routes
  scope module: :web do
    authenticated :user do
      root to: 'home#index', as: :authenticated_root

      post 'change_frame1_color', to: 'home#change_frame1_color'
      post 'change_frame2_color', to: 'home#change_frame2_color'
      post 'reset_colors', to: 'home#reset_colors'

      resources :users do
        member do
          post :lock
          post :unlock
          post :restore
        end
      end
    end

    devise_for :users, path: 'auth', controllers: {
      sessions: 'web/users/sessions',
      registrations: 'web/users/registrations',
      passwords: 'web/users/passwords',
      confirmations: 'web/users/confirmations',
      unlocks: 'web/users/unlocks'
    }

    devise_scope :user do
      unauthenticated do
        root to: 'users/sessions#new'
      end
    end
  end
        RUBY

        inject_into_file 'config/routes.rb', route_content, before: /^end\s*$/
      end

      def show_instructions
        say "\n" + "="*80, :green
        say "✅ Rails8Boilerplate успешно установлен!", :green
        say "="*80 + "\n", :green

        say "📦 Скопированные файлы:", :cyan
        say "  • Модели:       app/models/user.rb + concerns"
        say "  • Репозитории:  app/repositories/user_repository.rb"
        say "  • Контроллеры:  app/controllers/web/*"
        say "  • Policies:     app/policies/*"
        say "  • Views:        app/views/web/*"
        say "  • Layout:       удалён стандартный (используется из engine)"
        say "  • Specs:        spec/*"
        say "  • Initializers: config/initializers/devise.rb, pagy.rb"
        say "  • Локализации:  config/locales/*"
        say "  • Seeds:        db/seeds.rb"
        say "  • Миграции:     db/migrate/devise_create_users.rb"
        say "  • RuboCop:      .rubocop.yml"
        say "  • Kamal:        config/deploy.yml, .kamal/secrets" unless options[:no_kamal]
        say "  • GitHub:       .github/workflows/ci.yml, deploy.*.yml.disabled"
        say "  • Docker:       Dockerfile.*, docker-compose*.yml" unless options[:no_docker]
        say "  • Env:          .env.sample, .env.production.sample"
        say "  • Настройки:    config/application.rb (i18n, schema_format)\n"

        say "🎨 Остались в Engine (используются автоматически):", :cyan
        say "  • Assets:       AdminLTE стили и скрипты"
        say "  • Layouts:      app/views/layouts/lte/*"
        say "  • Helpers:      app/helpers/*"
        say "  • Генераторы:   lib/generators/custom_resource\n"

        say "⚙️  Следующие шаги:", :yellow
        step = 1
        say "  #{step}. Скопируйте .env.sample в .env и проверьте значения"
        step += 1
        say "  #{step}. Настройте config/initializers/devise.rb (mailer_sender, secret_key)"
        step += 1
        say "  #{step}. Настройте config/initializers/pagy.rb (при необходимости)"
        step += 1
        
        unless options[:no_kamal]
          say "  #{step}. Настройте .kamal/secrets (добавьте реальные значения переменных)"
          step += 1
          say "  #{step}. Настройте config/deploy.yml (проверьте servers и другие параметры)"
          step += 1
        end
        
        say "  #{step}. Настройте .env.production.sample (проверьте RAILS_MASTER_KEY и DB_PASSWORD)"
        step += 1
        say "  #{step}. Настройте GitHub Actions secrets (DEPLOY_SSH_KEY, SERVER_IP, и т.д.)"
        step += 1
        say "  #{step}. Выполните миграции: rails db:migrate"
        step += 1
        say "  #{step}. Создайте seed данные: rails db:seed"
        step += 1
        
        launch_command = options[:no_docker] ? "rails server" : "rails server или docker-compose up"
        say "  #{step}. Запустите сервер: #{launch_command}\n"

        say "🚀 Использование генератора custom_resource:", :yellow
        say "  rails generate custom_resource Product 'Товар'"
        say "  rails generate custom_resource References::Brand 'Бренд'\n"

        say "💡 Теперь весь код в вашем приложении!", :green
        say "="*80 + "\n", :green
      end

      private

      def migration_version
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end

      def self.next_migration_number(dirname)
        next_migration_number = current_migration_number(dirname) + 1
        ActiveRecord::Migration.next_migration_number(next_migration_number)
      end
    end
  end
end
