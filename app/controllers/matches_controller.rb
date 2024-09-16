# app/controllers/matches_controller.rb
class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :update, :destroy]

  # GET /matches
  def index
    @matches = policy_scope(Match).includes(:team_home, :team_away, :technical_manager, :anotador)
    render json: @matches, include: [:team_home, :team_away, :technical_manager, :anotador]
  end

  # GET /matches/:id
  def show
    authorize @match
    render json: @match, include: [:team_home, :team_away, :technical_manager, :anotador, :actions]
  end

  # POST /matches
  def create
    @match = Match.new(match_params)
    authorize @match

    if @match.save
      MatchMailer.match_assignment(@match).deliver_later
      render json: @match, status: :created, location: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /matches/:id
  def update
    authorize @match
    if @match.update(match_params)
      render json: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /matches/:id
  def destroy
    authorize @match
    @match.destroy
    head :no_content
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:team_home_id, :team_away_id, :date, :youtube_link, :technical_manager_id, :anotador_id)
  end
end
