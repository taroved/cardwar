class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables, id: :uuid do |t|
      t.string :stack_user
      t.string :stack_dealer
      t.string :stack_turn
      t.boolean :finished, :default => false, :null => false
      t.integer :winner, :default => 0, :null => false

      t.timestamps null: false
    end
  end
end
