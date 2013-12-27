class CreateProses < ActiveRecord::Migration
  def change
    create_table :proses do |t|
      t.integer :user_id, null:false
      t.string :title, default:"WIP"
      t.text :description, null:false
      t.integer :current_state, null:false

      t.timestamps
    end
  end
end
