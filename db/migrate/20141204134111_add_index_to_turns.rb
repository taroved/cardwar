class AddIndexToTurns < ActiveRecord::Migration
  def change
    add_index :turns, [:table_id, :created_at]
  end
end
