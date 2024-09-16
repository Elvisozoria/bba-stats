# app/serializers/team_serializer.rb
class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :logo_url, :players
  has_many :players

  def logo_url
    object.logo.attached? ? url_for(object.logo) : nil
  end

  def players
    object.players.count
  end
end
