class Match < ApplicationRecord
  belongs_to :team_home, class_name: 'Team'
  belongs_to :team_away, class_name: 'Team'
  belongs_to :technical_manager, class_name: 'User'
  belongs_to :anotador, class_name: 'User'

  has_many :actions, dependent: :destroy

  validates :date, presence: true
  validates :youtube_link, presence: true
end
