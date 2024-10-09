class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :technical_manager, class_name: 'User'
  belongs_to :anotador, class_name: 'User'

  has_many :actions, dependent: :destroy
  has_many :player_match_stats, dependent: :destroy


  validates :date, presence: true
  validates :youtube_link, presence: true

  def total_points
    home_team_total_points = Action.total_team_points_on_match(home_team.id, self)
    away_team_team_total_points = Action.total_team_points_on_match(away_team.id, self) 

    score = {
      "home_team_score": home_team_total_points.to_s ,
      "away_team_score": away_team_team_total_points.to_s
    } 
    return  score
  end
end
