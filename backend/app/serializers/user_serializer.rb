# app/serializers/user_serializer.rb
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :role
  belongs_to :player, serializer: PlayerSerializer, if: -> { object.player.present? }
end
