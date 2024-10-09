class Action < ApplicationRecord
  belongs_to :match
  belongs_to :team
  belongs_to :player
  belongs_to :assisted_by_player, class_name: 'Player', optional: true
  belongs_to :fouled_player, class_name: 'Player', optional: true

  ACTION_TYPES = %w[tiro_encestado tiro_fallado falta_personal falta_recibida asistencia perdida_de_balon].freeze
  # SECTIONS = %w[triple_centro triple_derecha triple_izquierda tiro_libre bajo_aro].freeze

  # validates :action_type, presence: true, inclusion: { in: ACTION_TYPES }
  # validates :section, presence: true, inclusion: { in: SECTIONS }
  validates :timestamp, presence: true
  validates :quarter, presence: true, numericality: { only_integer: true, greater_than: 0 }

  # scope :two_points, -> {where (section:"section2")}
  scope :two_points, -> { where(action_type:"tiro_encestado").where(section: ["section2", "section3", "section4", "section5", "section6", "section9", "section11", "section6"]) }
  scope :three_points, -> { where(action_type:"tiro_encestado").where(section: ["section1", "section7", "section8", "section10", "section12", "section13"]) }
  scope :one_point, -> {where(action_type: "tiro_libre_encestado")}


  def self.total_team_points_on_match(team_id,match)
    
    one_pointers = match.actions.one_point.where(team_id: team_id).count
    two_pointers = match.actions.two_points.where(team_id: team_id).count
    three_pointers = match.actions.three_points.where(team_id: team_id).count

    total_points = (one_pointers + (two_pointers * 2 ) + (three_pointers * 3))

  end

end
