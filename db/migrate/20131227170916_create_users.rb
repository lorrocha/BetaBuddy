class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null:false
      t.string :encrypted_password, null:false
      t.string :email, null:false
      t.date :last_login
      t.text :about_me

      t.timestamps
    end
  end
end
