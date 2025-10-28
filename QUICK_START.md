# ⚡ Быстрый старт Rails8Boilerplate

## 🎯 Для нового проекта

### 1. Создайте Rails приложение
```bash
rails new my_app --database=postgresql
cd my_app
```

### 2. Добавьте gem в Gemfile

**Локально:**
```ruby
gem 'rails8_boilerplate', path: '/path_to_project/rails8_boilerplate'
```

**Из Git:**
```ruby
gem 'rails8_boilerplate', git: 'https://github.com/infernaLwizarD/rails8_boilerplate.git'
```

### 3. Установите
```bash
bundle install
rails generate rails8_boilerplate:install
rails db:create
rails db:migrate
rails db:seed
```

### 4. Запустите
```bash
rails server
```

Откройте http://localhost:3000
- **Логин:** `admin`
- **Пароль:** `password`

## 🛠 Создание нового ресурса

### Простой ресурс
```bash
rails generate custom_resource Product 'Товар'
```

### С namespace
```bash
rails generate custom_resource Catalog::Service 'Услуга'
rails generate custom_resource References::Brand 'Бренд'
```

### После генерации

1. **Добавьте routes** (генератор покажет код)
2. **Добавьте в меню** (генератор покажет код)
3. **Выполните миграцию:**
```bash
rails db:migrate
```

## 📦 Что создаёт генератор

- ✅ Миграция
- ✅ Модель + Repository + Ransack
- ✅ Политика (Pundit)
- ✅ Контроллер
- ✅ Views
- ✅ Фабрика (FactoryBot)
- ✅ Тесты (create, update, delete)

## 🎁 Что включено в Engine

- ✅ User модель с Devise
- ✅ AdminLTE 4 интерфейс
- ✅ Pundit авторизация
- ✅ Ransack поиск
- ✅ Pagy пагинация
- ✅ Soft delete (Discard)
- ✅ RSpec тесты
- ✅ Локализация (ru)

## 📚 Документация

- **README.md** - основная документация
- **lib/generators/custom_resource/README.md** - документация генератора

## 🚀 Готово!

Теперь можно начинать разработку!
