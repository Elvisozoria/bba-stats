# app/serializers/match_serializer.rb
class MatchSerializer < ActiveModel::Serializer
  attributes :id, :date, :youtube_link
  belongs_to :home_team, serializer: TeamSerializer
  belongs_to :away_team, serializer: TeamSerializer
  belongs_to :technical_manager, serializer: UserSerializer
  belongs_to :anotador, serializer: UserSerializer

  has_many :actions do
    object.actions.order(timestamp: :desc)
  end
end
