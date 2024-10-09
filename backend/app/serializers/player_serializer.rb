# app/serializers/player_serializer.rb
class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :number, :height, :weight, :wingspan, :vertical_jump #, :image_url desactivado temporalmente
  belongs_to :team

  def image_url
    object.image.attached? ? url_for(object.image) : nil
  end
end
