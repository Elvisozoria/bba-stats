class PlayerMatchStat < ApplicationRecord
  belongs_to :match
  belongs_to :player

  validates :match_id, presence: true
  validates :player_id, presence: true
end
