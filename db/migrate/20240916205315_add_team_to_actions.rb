class AddTeamToActions < ActiveRecord::Migration[7.0]
  def change
    add_reference :actions, :team, null: false, foreign_key: true, default: 1
  end
end
