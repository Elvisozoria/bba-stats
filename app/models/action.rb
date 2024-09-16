class Action < ApplicationRecord
  belongs_to :match
  belongs_to :player
  belongs_to :assisted_by_player, class_name: 'Player', optional: true
  belongs_to :fouled_player, class_name: 'Player', optional: true

  ACTION_TYPES = %w[tiro_encestado tiro_fallado falta_personal falta_recibida asistencia perdida_de_balon].freeze
  SECTIONS = %w[triple_centro triple_derecha triple_izquierda tiro_libre bajo_aro].freeze

  validates :action_type, presence: true, inclusion: { in: ACTION_TYPES }
  validates :section, presence: true, inclusion: { in: SECTIONS }
  validates :timestamp, presence: true
  validates :quarter, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
