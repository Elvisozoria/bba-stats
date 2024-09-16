class CreateActions < ActiveRecord::Migration[7.0]
  def change
    create_table :actions do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.string :action_type
      t.time :timestamp
      t.string :section
      t.integer :quarter
      t.references :assisted_by_player, null: true, foreign_key: { to_table: :players }
      t.references :fouled_player, null: true, foreign_key: { to_table: :players }

      t.timestamps
    end
  end
end

