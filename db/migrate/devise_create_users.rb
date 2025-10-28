# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[8.0]
  def up
    # Создаём ENUM для ролей пользователей
    execute <<~SQL.squish
      CREATE TYPE user_role AS ENUM ('admin', 'user');
    SQL

    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Custom fields
      t.string   :username           # Логин пользователя
      t.column   :role, :user_role   # Роль пользователя (admin, user)
      t.datetime :discarded_at       # Мягкое удаление (Discard gem)

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
    add_index :users, :username,             unique: true
    add_index :users, :discarded_at
  end

  def down
    drop_table :users
    
    execute <<~SQL.squish
      DROP TYPE user_role;
    SQL
  end
end
