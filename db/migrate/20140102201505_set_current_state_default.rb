class SetCurrentStateDefault < ActiveRecord::Migration
  def up
    change_column :proses, :current_state, :integer, default: 1
  end

  def down
    change_column :proses, :current_state, :integer
  end
end
