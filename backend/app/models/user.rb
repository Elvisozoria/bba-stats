class User < ApplicationRecord
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable,
          :jwt_authenticatable,
          jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  belongs_to :player, optional: true

  has_many :assigned_matches, class_name: 'Match', foreign_key: 'anotador_id', dependent: :nullify
  has_many :managed_matches, class_name: 'Match', foreign_key: 'technical_manager_id', dependent: :nullify

  enum role: { admin: 0, supervisor: 1, anotador: 2, jugador: 3 }

  validates :role, presence: true
end
