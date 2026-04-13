
## 📁 Структура Rails8Boilerplate Engine

```
rails8_boilerplate/
├── app/
│   ├── assets/                    # AdminLTE стили и изображения
│   │   └── stylesheets/
│   │       ├── application.css
│   │       └── common/
│   │           ├── custom.css
│   │           └── plugins/       # AdminLTE, Bootstrap, FontAwesome
│   ├── helpers/                   # Универсальные helpers
│   │   ├── application_helper.rb
│   │   ├── buttons_helper.rb
│   │   ├── common_helper.rb
│   │   ├── font_awesome_helper.rb
│   │   ├── pagy_helper.rb
│   │   └── ransack_helper.rb
│   ├── javascript/                # AdminLTE JS
│   │   ├── application.js
│   │   ├── common/
│   │   │   └── plugins/           # AdminLTE, Bootstrap, Popper, FontAwesome
│   │   └── controllers/
│   │       ├── application.js
│   │       ├── autohide_controller.js
│   │       ├── hello_controller.js
│   │       ├── index.js
│   │       └── navigation_controller.js
│   └── views/
│       ├── layouts/               # AdminLTE шаблоны
│       │   ├── application.html.erb
│       │   ├── logon.html.erb
│       │   ├── mailer.html.erb
│       │   ├── mailer.text.erb
│       │   └── lte/
│       │       ├── _content.erb
│       │       ├── _footer.erb
│       │       ├── _header.erb
│       │       ├── _sidebar.erb
│       │       ├── _sidebar_menu.html.erb
│       │       └── partials/
│       │           ├── _breadcrumbs.erb
│       │           └── _flash.erb
│       └── pwa/
│           ├── manifest.json.erb
│           └── service-worker.js
├── config/
│   ├── importmap.rb               # JS-зависимости engine
│   └── locales/                   # Переводы (копируются)
│       ├── devise.en.yml
│       ├── devise.ru.yml
│       ├── en.yml
│       ├── pagy.ru.yml
│       └── ru.yml
├── db/
│   ├── migrate/
│   │   └── devise_create_users.rb # Шаблон миграции
│   └── seeds.rb                   # Начальные данные
└── lib/
    ├── core_ext/
    │   └── cputs.rb               # Цветной вывод в консоль
    ├── generators/
    │   ├── custom_resource/       # Генератор CRUD
    │   │   ├── custom_resource_generator.rb
    │   │   ├── README.md
    │   │   ├── USAGE
    │   │   └── templates/
    │   │       ├── controller.rb.tt
    │   │       ├── factory.rb.tt
    │   │       ├── migration.rb.tt
    │   │       ├── model.rb.tt
    │   │       ├── policy.rb.tt
    │   │       ├── ransack.rb.tt
    │   │       └── repository.rb.tt
    │   └── rails8_boilerplate/
    │       ├── install_generator.rb
    │       └── templates/         # Шаблоны для копирования
    │           ├── controllers/
    │           │   └── web/
    │           │       ├── application_controller.rb
    │           │       ├── home_controller.rb
    │           │       ├── users_controller.rb
    │           │       └── users/
    │           │           ├── confirmations_controller.rb
    │           │           ├── omniauth_callbacks_controller.rb
    │           │           ├── passwords_controller.rb
    │           │           ├── registrations_controller.rb
    │           │           ├── sessions_controller.rb
    │           │           └── unlocks_controller.rb
    │           ├── docker/
    │           │   ├── Dockerfile.development
    │           │   ├── Dockerfile.production
    │           │   ├── docker-compose.yml
    │           │   ├── docker-compose.development.yml
    │           │   └── docker-compose.production.yml
    │           ├── env.sample
    │           ├── env.production.sample
    │           ├── github/
    │           │   └── workflows/
    │           │       ├── ci.yml
    │           │       ├── deploy.dockerhub.yml.disabled
    │           │       └── deploy.ghcr.yml.disabled
    │           ├── initializers/
    │           │   ├── devise.rb
    │           │   └── pagy.rb
    │           ├── kamal/
    │           │   ├── deploy.yml
    │           │   └── secrets
    │           ├── models/
    │           │   ├── application_record.rb
    │           │   ├── cable_record.rb
    │           │   ├── cache_record.rb
    │           │   ├── queue_record.rb
    │           │   ├── user.rb
    │           │   └── concerns/
    │           │       ├── user_ransack.rb
    │           │       └── user_role_enum.rb
    │           ├── policies/
    │           │   ├── application_policy.rb
    │           │   └── user_policy.rb
    │           ├── repositories/
    │           │   └── user_repository.rb
    │           ├── rubocop.yml
    │           ├── spec/
    │           │   ├── factories/
    │           │   │   └── users.rb
    │           │   ├── features/
    │           │   │   ├── devise/
    │           │   │   │   ├── confirmation_resend_spec.rb
    │           │   │   │   ├── lockable_spec.rb
    │           │   │   │   ├── password_recovery_spec.rb
    │           │   │   │   ├── registration_spec.rb
    │           │   │   │   └── sign_in_spec.rb
    │           │   │   └── users/
    │           │   │       ├── create_spec.rb
    │           │   │       ├── delete_spec.rb
    │           │   │       ├── lock_spec.rb
    │           │   │       └── update_spec.rb
    │           │   ├── rails_helper.rb
    │           │   ├── spec_helper.rb
    │           │   └── support/
    │           │       ├── capybara.rb
    │           │       ├── feature_helpers.rb
    │           │       └── mail_helpers.rb
    │           └── views/
    │               └── web/
    │                   ├── home/
    │                   │   ├── index.html.erb
    │                   │   ├── _frame1.html.erb
    │                   │   └── _frame2.html.erb
    │                   └── users/
    │                       ├── index.html.erb
    │                       ├── show.html.erb
    │                       ├── new.html.erb
    │                       ├── edit.html.erb
    │                       ├── _form.html.erb
    │                       ├── confirmations/
    │                       │   └── new.html.erb
    │                       ├── mailer/
    │                       │   ├── confirmation_instructions.html.erb
    │                       │   ├── email_changed.html.erb
    │                       │   ├── password_change.html.erb
    │                       │   ├── reset_password_instructions.html.erb
    │                       │   └── unlock_instructions.html.erb
    │                       ├── partials/
    │                       │   └── _search_form.html.erb
    │                       ├── passwords/
    │                       │   ├── edit.html.erb
    │                       │   └── new.html.erb
    │                       ├── registrations/
    │                       │   ├── edit.html.erb
    │                       │   └── new.html.erb
    │                       ├── sessions/
    │                       │   └── new.html.erb
    │                       ├── shared/
    │                       │   ├── _error_messages.html.erb
    │                       │   └── _links.html.erb
    │                       └── unlocks/
    │                           └── new.html.erb
    ├── rails8_boilerplate/
    │   ├── engine.rb
    │   └── version.rb
    └── rails8_boilerplate.rb
```

---

## 🎯 Что происходит при установке

### Команда

```bash
rails generate rails8_boilerplate:install
```

### Результат

```
my_awesome_app/
├── .env                               # Переменные окружения
├── .env.sample                        # Пример .env
├── .env.production.sample             # Пример для production
├── .github/
│   └── workflows/
│       ├── ci.yml                     # CI pipeline
│       ├── deploy.dockerhub.yml.disabled
│       └── deploy.ghcr.yml.disabled
├── .kamal/
│   ├── secrets                        # Kamal secrets
│   └── secrets.sample
├── .rubocop.yml                       # RuboCop конфигурация
├── Dockerfile.development             # Docker (dev)
├── Dockerfile.production              # Docker (prod)
├── docker-compose.yml
├── docker-compose.development.yml
├── docker-compose.production.yml
├── app/
│   ├── models/
│   │   ├── application_record.rb      # Скопировано
│   │   ├── cable_record.rb            # Скопировано
│   │   ├── cache_record.rb            # Скопировано
│   │   ├── queue_record.rb            # Скопировано
│   │   ├── user.rb                    # Скопировано
│   │   └── concerns/
│   │       ├── user_ransack.rb        # Скопировано
│   │       └── user_role_enum.rb      # Скопировано
│   ├── repositories/
│   │   └── user_repository.rb         # Скопировано
│   ├── controllers/
│   │   └── web/                       # Скопировано
│   │       ├── application_controller.rb
│   │       ├── home_controller.rb
│   │       ├── users_controller.rb
│   │       └── users/
│   │           ├── confirmations_controller.rb
│   │           ├── omniauth_callbacks_controller.rb
│   │           ├── passwords_controller.rb
│   │           ├── registrations_controller.rb
│   │           ├── sessions_controller.rb
│   │           └── unlocks_controller.rb
│   ├── policies/
│   │   ├── application_policy.rb      # Скопировано
│   │   └── user_policy.rb             # Скопировано
│   └── views/
│       └── web/                       # Скопировано
│           ├── home/
│           │   ├── index.html.erb
│           │   ├── _frame1.html.erb
│           │   └── _frame2.html.erb
│           └── users/
│               ├── index.html.erb
│               ├── show.html.erb
│               ├── new.html.erb
│               ├── edit.html.erb
│               ├── _form.html.erb
│               ├── confirmations/
│               ├── mailer/
│               ├── partials/
│               ├── passwords/
│               ├── registrations/
│               ├── sessions/
│               ├── shared/
│               └── unlocks/
├── config/
│   ├── deploy.yml                     # Kamal deploy config
│   ├── initializers/
│   │   ├── devise.rb                  # Скопировано
│   │   └── pagy.rb                    # Скопировано
│   ├── locales/
│   │   ├── devise.en.yml              # Скопировано
│   │   ├── devise.ru.yml              # Скопировано
│   │   ├── en.yml                     # Скопировано
│   │   ├── pagy.ru.yml                # Скопировано
│   │   └── ru.yml                     # Скопировано
│   ├── routes.rb                      # Добавлены routes
│   └── application.rb                 # Настроен (i18n, schema_format)
├── db/
│   ├── migrate/
│   │   └── XXXX_devise_create_users.rb  # Скопировано с новым timestamp
│   └── seeds.rb                       # Скопировано
└── spec/                              # Скопировано
    ├── factories/
    │   └── users.rb
    ├── features/
    │   ├── devise/
    │   │   ├── confirmation_resend_spec.rb
    │   │   ├── lockable_spec.rb
    │   │   ├── password_recovery_spec.rb
    │   │   ├── registration_spec.rb
    │   │   └── sign_in_spec.rb
    │   └── users/
    │       ├── create_spec.rb
    │       ├── delete_spec.rb
    │       ├── lock_spec.rb
    │       └── update_spec.rb
    ├── rails_helper.rb
    ├── spec_helper.rb
    └── support/
        ├── capybara.rb
        ├── feature_helpers.rb
        └── mail_helpers.rb
```

---

## ✅ Преимущества такой структуры

### 1. Нет конфликтов
```ruby
# ❌ ПЛОХО: Модели и в engine, и в приложении
rails8_boilerplate/app/models/user.rb       # Загружается
my_awesome_app/app/models/user.rb           # Тоже загружается → КОНФЛИКТ!

# ✅ ХОРОШО: Модели только в приложении
rails8_boilerplate/lib/generators/.../templates/models/user.rb  # Шаблон
my_awesome_app/app/models/user.rb                                # Скопировано
```

### 2. Полный контроль
```ruby
# Можете радикально менять код без конфликтов
class User < ApplicationRecord
  # Ваша кастомная логика
  has_many :posts
  has_many :comments
  
  # Можете удалить Devise
  # devise :database_authenticatable
  
  # Можете добавить свою аутентификацию
  has_secure_password
end
```

### 3. Независимость от engine
```ruby
# После установки можете удалить engine из Gemfile
# gem 'rails8_boilerplate'  # Можно удалить!

# Но лучше оставить для:
# - AdminLTE UI компонентов (layouts, assets, JS)
# - Stimulus controllers (autohide, navigation)
# - Helpers (buttons, fontawesome, pagy, ransack, common)
# - Генератора custom_resource
```

### 4. Легко обновлять
```bash
# Если вышла новая версия engine с улучшениями:
rails generate rails8_boilerplate:install --force

# Выборочно применяете изменения через git diff
git diff app/models/user.rb
```

---

## 🎨 Что использует Engine автоматически

### Layouts
```erb
<!-- app/views/web/users/index.html.erb -->
<!-- Использует layout из engine -->
<% content_for :title, 'Пользователи' %>

<div class="content">
  <!-- Ваш контент -->
</div>

<!-- Layouts из engine:
     rails8_boilerplate/app/views/layouts/application.html.erb (основной)
     rails8_boilerplate/app/views/layouts/logon.html.erb (авторизация)
     rails8_boilerplate/app/views/layouts/lte/* (партиалы AdminLTE)
-->
```

### Helpers
```erb
<!-- Используете helpers из engine -->
<%= pagy_nav(@pagy) %>
<%= fa_icon('user') %>
<%= button_to_edit(user_path(@user)) %>
```

### Assets
```erb
<!-- AdminLTE стили и скрипты подключаются автоматически через engine -->
<!-- JS подключается через importmap (bootstrap, adminlte, fontawesome) -->
<!-- CSS подключается через asset pipeline -->
```

---

## 🚀 Workflow разработки

### 1. Установка
```bash
# Добавляете engine
gem 'rails8_boilerplate', git: '...'
bundle install

# Устанавливаете (копируете код)
rails generate rails8_boilerplate:install
rails db:migrate
```

### 2. Кастомизация
```ruby
# Модифицируете скопированный код
# app/models/user.rb
class User < ApplicationRecord
  # Добавляете свои ассоциации
  has_many :posts
  has_many :comments
  
  # Добавляете свои методы
  def full_name
    "#{first_name} #{last_name}"
  end
end
```

### 3. Создание новых ресурсов
```bash
# Используете генератор из engine
rails generate custom_resource Product 'Товар'
rails generate custom_resource References::Brand 'Бренд'
```

### 4. Обновление UI
```ruby
# Если нужно изменить layout:
# 1. Скопируйте из engine в приложение
cp rails8_boilerplate/app/views/layouts/application.html.erb \
   app/views/layouts/application.html.erb

# 2. Модифицируйте под себя
```

---

## 📝 Checklist после установки

- [ ] Скопировать `.env.sample` в `.env` и проверить значения
- [ ] Настроить `config/initializers/devise.rb` (mailer_sender, secret_key)
- [ ] Настроить `config/initializers/pagy.rb` (при необходимости)
- [ ] Настроить `.kamal/secrets` и `config/deploy.yml` (при использовании Kamal)
- [ ] Настроить `.env.production.sample` для production-окружения
- [ ] Настроить GitHub Actions secrets (DEPLOY_SSH_KEY, SERVER_IP и т.д.)
- [ ] Проверить `.rubocop.yml` и адаптировать под проект
- [ ] Выполнить миграции: `rails db:migrate`
- [ ] Создать seed данные: `rails db:seed`
- [ ] Запустить тесты: `rspec`
- [ ] Проверить работу: `rails server` / `docker compose up`
- [ ] Кастомизировать модели под свои нужды
- [ ] Добавить свои ресурсы через `rails generate custom_resource`

---

## 💡 FAQ

### Q: Можно ли удалить engine после установки?
**A:** Технически да, но лучше оставить для:
- AdminLTE UI компонентов (layouts, assets, helpers, JS)
- Stimulus controllers (autohide, navigation)
- Генератора `custom_resource`
- Обновлений в будущем

### Q: Что делать при конфликте файлов?
**A:** Используйте `--force` или `--skip`:
```bash
rails generate rails8_boilerplate:install --force  # Перезаписать всё
rails generate rails8_boilerplate:install --skip   # Пропустить существующие
```

### Q: Как обновить код из engine?
**A:** 
```bash
# 1. Обновите engine
bundle update rails8_boilerplate

# 2. Запустите генератор с --force
rails generate rails8_boilerplate:install --force

# 3. Проверьте изменения через git
git diff

# 4. Выборочно примените нужные изменения
```

### Q: Можно ли использовать без Docker?
**A:** Да, просто используйте обычные команды Rails:
```bash
bundle install
rails generate rails8_boilerplate:install
rails db:migrate
rails server
```
