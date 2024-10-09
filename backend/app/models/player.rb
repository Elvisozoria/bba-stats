class Player < ApplicationRecord
  belongs_to :team
  has_many :actions, dependent: :destroy
  has_one_attached :image

  has_one :user

  validates :name, presence: true
end

