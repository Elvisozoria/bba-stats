class ChangeTeamsWordingOnMatches < ActiveRecord::Migration[7.0]
  def change
    rename_column :matches, :home_team_id, :home_team_id
    rename_column :matches, :away_team_id, :away_team_id
  end
end
