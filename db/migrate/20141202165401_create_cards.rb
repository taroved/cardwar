class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :rate
      t.integer :suit
    end
  end
end
