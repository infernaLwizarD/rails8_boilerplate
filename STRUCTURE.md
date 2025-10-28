# Структура Rails8Boilerplate Engine

## 📁 Финальная структура

### В Engine (не копируется)

```
rails8_boilerplate/
├── app/
│   ├── assets/                    # ✅ AdminLTE стили и изображения
│   │   ├── images/
│   │   └── stylesheets/
│   ├── helpers/                   # ✅ Универсальные helpers
│   │   ├── application_helper.rb
│   │   ├── buttons_helper.rb
│   │   ├── common_helper.rb
│   │   ├── font_awesome_helper.rb
│   │   ├── pagy_helper.rb
│   │   └── ransack_helper.rb
│   ├── javascript/                # ✅ AdminLTE JS
│   │   ├── application.js
│   │   ├── common/
│   │   └── controllers/
│   └── views/
│       └── layouts/               # ✅ AdminLTE шаблоны
│           └── lte/
│               ├── application.html.erb
│               ├── auth.html.erb
│               └── partials/
│                   ├── _header.html.erb
│                   ├── _sidebar.html.erb
│                   ├── _footer.html.erb
│                   ├── _flash.html.erb
│                   └── _breadcrumbs.html.erb
├── config/
│   └── locales/                   # ✅ Переводы (копируются)
│       ├── ru.yml
│       └── pagy.ru.yml
├── db/
│   └── migrate/
│       └── devise_create_users.rb # ✅ Шаблон миграции
└── lib/
    ├── generators/
    │   ├── custom_resource/       # ✅ Генератор CRUD
    │   │   ├── custom_resource_generator.rb
    │   │   └── templates/
    │   └── rails8_boilerplate/
    │       ├── install_generator.rb
    │       └── templates/         # 📦 Шаблоны для копирования
    │           ├── controllers/
    │           │   └── web/
    │           │       ├── application_controller.rb
    │           │       ├── home_controller.rb
    │           │       ├── users_controller.rb
    │           │       └── users/
    │           │           ├── sessions_controller.rb
    │           │           ├── registrations_controller.rb
    │           │           ├── passwords_controller.rb
    │           │           ├── confirmations_controller.rb
    │           │           └── unlocks_controller.rb
    │           ├── initializers/
    │           │   ├── devise.rb
    │           │   └── pagy.rb
    │           ├── models/
    │           │   ├── user.rb
    │           │   ├── application_record.rb
    │           │   └── concerns/
    │           │       ├── user_repository.rb
    │           │       ├── user_ransack.rb
    │           │       └── user_role_enum.rb
    │           ├── policies/
    │           │   ├── application_policy.rb
    │           │   └── user_policy.rb
    │           ├── spec/
    │           │   ├── factories/
    │           │   ├── features/
    │           │   ├── models/
    │           │   ├── policies/
    │           │   ├── rails_helper.rb
    │           │   ├── spec_helper.rb
    │           │   └── support/
    │           └── views/
    │               └── web/
    │                   ├── home/
    │                   └── users/
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
├── app/
│   ├── models/
│   │   ├── user.rb                    # ✅ Скопировано из templates
│   │   └── concerns/
│   │       ├── user_repository.rb     # ✅ Скопировано
│   │       ├── user_ransack.rb        # ✅ Скопировано
│   │       └── user_role_enum.rb      # ✅ Скопировано
│   ├── controllers/
│   │   └── web/                       # ✅ Скопировано из templates
│   │       ├── application_controller.rb
│   │       ├── home_controller.rb
│   │       ├── users_controller.rb
│   │       └── users/
│   │           ├── sessions_controller.rb
│   │           ├── registrations_controller.rb
│   │           ├── passwords_controller.rb
│   │           ├── confirmations_controller.rb
│   │           └── unlocks_controller.rb
│   ├── policies/
│   │   ├── application_policy.rb      # ✅ Скопировано
│   │   └── user_policy.rb             # ✅ Скопировано
│   └── views/
│       └── web/                       # ✅ Скопировано из templates
│           ├── home/
│           │   └── index.html.erb
│           └── users/
│               ├── index.html.erb
│               ├── show.html.erb
│               ├── new.html.erb
│               ├── edit.html.erb
│               └── _form.html.erb
├── config/
│   ├── initializers/
│   │   ├── devise.rb                  # ✅ Скопировано
│   │   └── pagy.rb                    # ✅ Скопировано
│   ├── locales/
│   │   ├── ru.yml                     # ✅ Скопировано
│   │   └── pagy.ru.yml                # ✅ Скопировано
│   └── routes.rb                      # ✅ Добавлены routes
├── db/
│   └── migrate/
│       └── 20250130_devise_create_users.rb  # ✅ Скопировано с новым timestamp
└── spec/                              # ✅ Скопировано из templates
    ├── factories/
    │   └── users.rb
    ├── features/
    │   └── users/
    │       ├── create_spec.rb
    │       ├── update_spec.rb
    │       ├── delete_spec.rb
    │       └── search_spec.rb
    ├── models/
    │   └── user_spec.rb
    ├── policies/
    │   └── user_policy_spec.rb
    ├── rails_helper.rb
    ├── spec_helper.rb
    └── support/
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
# - AdminLTE UI компонентов
# - Генератора custom_resource
# - Helpers
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

<!-- Layout: rails8_boilerplate/app/views/layouts/lte/application.html.erb -->
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
<!-- Используете стили из engine -->
<!-- AdminLTE автоматически подключается -->
<link rel="stylesheet" href="<%= asset_path('adminlte/adminlte.css') %>">
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
cp rails8_boilerplate/app/views/layouts/lte/application.html.erb \
   app/views/layouts/application.html.erb

# 2. Модифицируйте под себя
```

---

## 📝 Checklist после установки

- [ ] Настроить `config/initializers/devise.rb` (mailer_sender, secret_key)
- [ ] Настроить `config/initializers/pagy.rb` (при необходимости)
- [ ] Выполнить миграции: `rails db:migrate`
- [ ] Создать seed данные: `rails db:seed`
- [ ] Запустить тесты: `rspec`
- [ ] Проверить работу: `rails server`
- [ ] Кастомизировать модели под свои нужды
- [ ] Добавить свои ресурсы через `rails generate custom_resource`

---

## 💡 FAQ

### Q: Можно ли удалить engine после установки?
**A:** Технически да, но лучше оставить для:
- AdminLTE UI компонентов (layouts, assets, helpers)
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
