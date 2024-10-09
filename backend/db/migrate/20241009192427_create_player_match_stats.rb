class CreatePlayerMatchStats < ActiveRecord::Migration[7.0]
  def change
    create_table :player_match_stats do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.integer :points
      t.integer :field_goals_made
      t.integer :field_goals_attempted
      t.integer :free_throws_made
      t.integer :free_throws_attempted
      t.integer :three_points_made
      t.integer :three_points_attempted
      t.integer :rebounds_offensive
      t.integer :rebounds_defensive
      t.integer :assists
      t.integer :steals
      t.integer :blocks
      t.integer :turnovers

      t.timestamps
    end
  end
end
