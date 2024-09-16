# app/controllers/players_controller.rb
class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :update, :destroy]

  # GET /players
  def index
    @players = policy_scope(Player).includes(:team)
    render json: @players, include: [:team, :image]
  end

  # GET /players/:id
  def show
    authorize @player
    render json: @player, include: [:team, :image]
  end

  # POST /players
  def create
    @player = Player.new(player_params)
    authorize @player

    if @player.save
      render json: @player, status: :created, location: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /players/:id
  def update
    authorize @player
    if @player.update(player_params)
      render json: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # DELETE /players/:id
  def destroy
    authorize @player
    @player.destroy
    head :no_content
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :team_id, :position, :number, :height, :weight, :wingspan, :vertical_jump, :image)
  end
end
