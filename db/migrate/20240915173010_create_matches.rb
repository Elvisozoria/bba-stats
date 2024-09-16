class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :team_home, null: false, foreign_key: { to_table: :teams }
      t.references :team_away, null: false, foreign_key: { to_table: :teams }
      t.datetime :date, null: false
      t.string :youtube_link, null: false
      t.references :technical_manager, null: false, foreign_key: { to_table: :users }
      t.references :anotador, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
