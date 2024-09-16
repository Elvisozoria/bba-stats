class AddPlayerIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :player, null: true, foreign_key: true
  end
end
