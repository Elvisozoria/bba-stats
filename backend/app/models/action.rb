class Action < ApplicationRecord
  belongs_to :match
  belongs_to :team
  belongs_to :player
  belongs_to :assisted_by_player, class_name: 'Player', optional: true
  belongs_to :fouled_player, class_name: 'Player', optional: true

  after_save :update_player_match_stats
  after_destroy :revert_player_match_stats

  ACTION_TYPES = %w[tiro_encestado tiro_fallado falta_personal falta_recibida asistencia perdida_de_balon].freeze

  def self.total_team_points_on_match(team_id,match)
    
    one_pointers = match.actions.one_point.where(team_id: team_id).count
    two_pointers = match.actions.two_points.where(team_id: team_id).count
    three_pointers = match.actions.three_points.where(team_id: team_id).count

    total_points = (one_pointers + (two_pointers * 2 ) + (three_pointers * 3))

  end

  # Este método actualizará las estadísticas del jugador
  def update_player_match_stats
    player_stat = PlayerMatchStat.find_or_create_by(match: match, player: player)

    case action_type
    when 'tiro_encestado'
      if section.include?('triple')  # si es un tiro de tres puntos
        player_stat.three_points_made += 1
        player_stat.points += 3
      else # cualquier otro tiro
        player_stat.field_goals_made += 1
        player_stat.points += 2
      end
      player_stat.field_goals_attempted += 1
    when 'tiro_fallado'
      player_stat.field_goals_attempted += 1
    when 'tiro_libre_encestado'
      player_stat.free_throws_made += 1
      player_stat.free_throws_attempted += 1
      player_stat.points += 1
    when 'tiro_libre_fallado'
      player_stat.free_throws_attempted += 1
    when 'rebote_ofensivo'
      player_stat.rebounds_offensive += 1
    when 'rebote_defensivo'
      player_stat.rebounds_defensive += 1
    when 'asistencia'
      player_stat.assists += 1
    when 'robo'
      player_stat.steals += 1
    when 'bloqueo'
      player_stat.blocks += 1
    when 'perdida_de_balon'
      player_stat.turnovers += 1
    end

    player_stat.save
  end

  # Este método revertirá las estadísticas en caso de eliminar la acción
  def revert_player_match_stats
    player_stat = PlayerMatchStat.find_by(match: match, player: player)
    return unless player_stat

    case action_type
    when 'tiro_encestado'
      if section.include?('triple')
        player_stat.three_points_made -= 1
        player_stat.points -= 3
      else
        player_stat.field_goals_made -= 1
        player_stat.points -= 2
      end
      player_stat.field_goals_attempted -= 1
    when 'tiro_fallado'
      player_stat.field_goals_attempted -= 1
    when 'tiro_libre_encestado'
      player_stat.free_throws_made -= 1
      player_stat.free_throws_attempted -= 1
      player_stat.points -= 1
    when 'tiro_libre_fallado'
      player_stat.free_throws_attempted -= 1
    when 'rebote_ofensivo'
      player_stat.rebounds_offensive -= 1
    when 'rebote_defensivo'
      player_stat.rebounds_defensive -= 1
    when 'asistencia'
      player_stat.assists -= 1
    when 'robo'
      player_stat.steals -= 1
    when 'bloqueo'
      player_stat.blocks -= 1
    when 'perdida_de_balon'
      player_stat.turnovers -= 1
    end

    player_stat.save
  end
end

