class PlayerMatchStatsController < ApplicationController
  def index
    @match = Match.find(params[:id])
    @player_match_stats = @match.player_match_stats.includes(:player)
    puts @player_match_stats
    render json: @player_match_stats, include: [:player]
  end
end

sdfs
