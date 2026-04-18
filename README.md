# Rails8Boilerplate

**Boilerplate Rails Engine** для мгновенного старта Rails 8 приложений.

## Концепция

Это **не библиотека**, а **стартовый шаблон**:
- Генератор **копирует весь код** в ваше приложение
- Вы получаете **полный контроль** над кодом
- Модифицируйте что угодно — это **ваш код**
- Engine остаётся только для **UI компонентов** (AdminLTE, layouts, helpers)
- **Нет конфликтов** — в engine нет моделей/контроллеров, только шаблоны

## Что включено

### Копируется в приложение:
- **Аутентификация** — Devise с готовой моделью User
- **CRUD пользователей** — контроллеры, views, policies
- **Репозитории** — User repository (паттерн Repository)
- **RSpec тесты** — feature-тесты для Devise и User CRUD
- **Поиск и фильтрация** — Ransack + Pagy
- **Авторизация** — Pundit policies
- **Views** — представления для User CRUD, Devise (sessions, registrations, passwords, confirmations, unlocks), mailer-шаблоны
- **Модели** — User, ApplicationRecord, CableRecord, CacheRecord, QueueRecord + concerns
- **Initializers** — Devise, Pagy
- **Локализации** — ru.yml, en.yml, devise.ru.yml, devise.en.yml, pagy.ru.yml
- **Seeds** — начальные данные
- **RuboCop** — конфигурация линтера
- **Docker** — Dockerfile.development, Dockerfile.production, docker-compose файлы
- **Kamal** — deploy.yml, secrets для деплоя
- **GitHub Actions** — CI workflow, deploy workflows (disabled)
- **Env** — .env.sample, .env.production.sample
- **Генератор CRUD** — создание новых ресурсов одной командой

### Остаётся в Engine:
- **AdminLTE 4** — современный UI фреймворк (CSS, JS, Bootstrap, FontAwesome)
- **Layouts** — application, logon, партиалы (header, sidebar, footer, flash, breadcrumbs)
- **Helpers** — ApplicationHelper, ButtonsHelper, CommonHelper, FontAwesomeHelper, PagyHelper
- **Assets** — стили, скрипты, изображения
- **Stimulus controllers** — autohide, navigation
- **Importmap** — конфигурация JS-зависимостей

## Установка

Добавьте в Gemfile:

```ruby
gem 'rails8_boilerplate', git: 'https://github.com/infernaLwizarD/rails8_boilerplate.git'
```

Или для локальной разработки:

```ruby
gem 'rails8_boilerplate', path: '/path_to_project/rails8_boilerplate'
```
Если используется докер:
```yml
# Монтируем rails8_boilerplate engine в docker-compose.yml
volumes:
    - /path_to_project/rails8_boilerplate:/rails8_boilerplate
```
В Gemfile добавляем:
```ruby
gem 'rails8_boilerplate', path: '/rails8_boilerplate'
```

Затем выполняем:

```bash
bundle install
rails generate rails8_boilerplate:install
rails db:migrate
rails db:seed

# Или для докера:

docker compose run --rm web bundle install
docker compose run --rm web rails generate rails8_boilerplate:install
docker compose run --rm web rails db:migrate
docker compose run --rm web rails db:seed
```

### Опции генератора:

```bash
rails generate rails8_boilerplate:install [options]

# --no-kamal      Пропустить установку Kamal конфигурации
# --no-docker     Пропустить установку Docker конфигурации
# --main-branch   Главная ветка проекта (main/master), по умолчанию: main
# --force         Перезаписать существующие файлы без запроса подтверждения
```

### Что делает генератор установки:

1. **Копирует миграцию** — таблица `users` с полями:
   - Devise (email, password, confirmable, lockable, trackable)
   - `username` — логин пользователя
   - `role` — роль (admin/user) через PostgreSQL ENUM
   - `discarded_at` — мягкое удаление
2. **Копирует код** — модели, репозитории, контроллеры, views, policies, тесты, initializers, локализации, seeds
3. **Удаляет стандартный layout** — `app/views/layouts/application.html.erb` (используется layout из engine)
4. **Настраивает ApplicationController** — добавляет `Pundit::Authorization` и `Pagy::Backend`
5. **Копирует RuboCop конфигурацию** — `.rubocop.yml`
6. **Копирует Docker конфигурацию** — Dockerfile.development/production, docker-compose файлы (пропуск: `--no-docker`)
7. **Создаёт .env файлы** — `.env`, `.env.sample`, `.env.production.sample`
8. **Настраивает Kamal** — запускает `kamal init`, копирует `deploy.yml` и `secrets` (пропуск: `--no-kamal`)
9. **Настраивает GitHub Actions** — CI workflow, deploy workflows (disabled)
10. **Настраивает JavaScript** — добавляет импорты bootstrap, adminlte, fontawesome в `application.js`
11. **Настраивает приложение**:
    - `config.i18n.default_locale = :ru`
    - `config.active_record.schema_format = :sql`
12. **Добавляет routes** — для Devise и User CRUD

## Использование

### Генератор custom_resource

Создание полноценного CRUD ресурса:

```bash
rails generate custom_resource Product 'Товар'
rails generate custom_resource References::Brand 'Бренд'
```

Генератор создаёт:
- Миграцию
- Модель с concern (ransack)
- Репозиторий
- Политику (Pundit)
- Контроллер
- Views (index, show, new, edit, form)
- Фабрику (FactoryBot)
- Feature тесты (RSpec)

### Компоненты

#### Модели
- `User` — модель пользователя с Devise
- `ApplicationRecord`, `CableRecord`, `CacheRecord`, `QueueRecord` — базовые модели
- Concerns: `UserRansack`, `UserRoleEnum`

#### Репозитории
- `UserRepository` — паттерн Repository для работы с пользователями

#### Контроллеры
- `Web::ApplicationController` — базовый контроллер
- `Web::UsersController` — управление пользователями
- `Web::HomeController` — главная страница
- `Web::Users::SessionsController` — вход / выход
- `Web::Users::RegistrationsController` — регистрация
- `Web::Users::PasswordsController` — восстановление пароля
- `Web::Users::ConfirmationsController` — подтверждение email
- `Web::Users::UnlocksController` — разблокировка
- `Web::Users::OmniauthCallbacksController` — OAuth

#### Helpers
- `ApplicationHelper` — общие хелперы
- `ButtonsHelper` — кнопки для интерфейса
- `CommonHelper` — общие вспомогательные методы
- `FontAwesomeHelper` — иконки
- `PagyHelper` — пагинация

#### Policies
- `ApplicationPolicy` — базовая политика
- `UserPolicy` — политика для пользователей

## Зависимости

### Runtime:
- **Rails** ~> 8.1.2
- **Devise** ~> 4.9 (аутентификация)
- **Discard** ~> 1.4 (soft delete)
- **Morph** ~> 0.3 (склонение слов)
- **Pagy** ~> 9.4 (пагинация)
- **Pundit** ~> 2.3 (авторизация)
- **Ransack** ~> 4.2 (поиск)
- **Colorize** ~> 1.1 (цветной вывод)
- **CSV** (экспорт)

### Development:
- **RSpec** ~> 8.0, **Capybara** ~> 3.40, **Selenium** ~> 4.27
- **FactoryBot** ~> 6.4, **Faker** ~> 3.5
- **RuboCop** ~> 1.69 (+ rails, rspec, performance, factory_bot)
- **EmailSpec** ~> 2.2, **TestProf** ~> 1.4
