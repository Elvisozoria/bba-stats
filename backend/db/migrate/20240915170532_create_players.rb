class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.references :team, null: false, foreign_key: true
      t.string :position
      t.integer :number
      t.float :height
      t.float :weight
      t.float :wingspan
      t.float :vertical_jump
      t.string :image

      t.timestamps
    end
  end
end
