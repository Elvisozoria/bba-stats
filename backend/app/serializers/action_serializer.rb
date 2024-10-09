# app/serializers/action_serializer.rb
class ActionSerializer < ActiveModel::Serializer
  attributes :id, :action_type, :timestamp, :section, :quarter
  belongs_to :player, serializer: PlayerSerializer
  belongs_to :assisted_by_player, serializer: PlayerSerializer, if: -> { object.assisted_by_player.present? }
  belongs_to :fouled_player, serializer: PlayerSerializer, if: -> { object.fouled_player.present? }
end
