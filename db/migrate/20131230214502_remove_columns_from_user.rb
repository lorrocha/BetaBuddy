class RemoveColumnsFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :encrypted_password
    remove_column :users, :email
    remove_column :users, :last_login
    remove_column :users, :created_at
    remove_column :users, :updated_at
  end

  def down
    add_column :users, :encrypted_password, :string
    add_column :users, :email, :string
    add_column :users, :last_login, :datetime
    add_column :users, :created_at, :datetime
    add_column :users, :updated_at, :datetime
  end
end
