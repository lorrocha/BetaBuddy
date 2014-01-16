class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :author, null:false
      t.string :description, null:false

      t.timestamps
    end
  end
end
