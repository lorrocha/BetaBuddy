class RemoveCurrentStateFromProses < ActiveRecord::Migration
  def up
    remove_column :proses, :current_state
  end

  def down
    add_column :proses, :current_state, :string, default:1
  end
end
