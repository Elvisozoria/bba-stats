# app/serializers/match_serializer.rb
class MatchSerializer < ActiveModel::Serializer
  attributes :id, :date, :youtube_link
  belongs_to :team_home, serializer: TeamSerializer
  belongs_to :team_away, serializer: TeamSerializer
  belongs_to :technical_manager, serializer: UserSerializer
  belongs_to :anotador, serializer: UserSerializer
  has_many :actions
end
