class CreateProseTags < ActiveRecord::Migration
  def change
    create_table :prose_tags do |t|
      t.integer :prose_id, null:false
      t.integer :genre_id, null:false

      t.timestamps
    end
  end
end
