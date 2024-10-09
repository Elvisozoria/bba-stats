# app/serializers/team_serializer.rb
class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :logo_url, :players

  def logo_url
    object.logo.attached? ? url_for(object.logo) : nil
  end

  def players
    object.players.map do |player|
      {
        id: player.id,
        name: player.name
      }
    end
  end
end
