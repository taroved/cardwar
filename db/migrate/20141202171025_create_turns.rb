class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.references :table, type: :uuid, index: true
      t.integer :card_dealer_id
      t.integer :card_user_id

      t.timestamps null: false
    end
    add_foreign_key :turns, :tables
  end
end
