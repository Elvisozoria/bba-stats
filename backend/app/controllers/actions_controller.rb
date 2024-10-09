# app/controllers/actions_controller.rb
class ActionsController < ApplicationController
  before_action :set_action, only: [:show, :update, :destroy]

  # GET /actions
  def index
    @actions = policy_scope(Action).includes(:player, :assisted_by_player, :fouled_player)
    render json: @actions.two_points, include: [:player, :assisted_by_player, :fouled_player]
  end

  # GET /actions/:id
  def show
    authorize @action
    render json: @action, include: [:player, :assisted_by_player, :fouled_player]
  end

  # POST /actions
  def create
    @action = Action.new(action_params)
    authorize @action
    @action.team_id = @action.player.team.id
  
    if @action.save
      render json: @action, status: :created, location: @action
    else
      render json: @action.errors, status: :unprocessable_entity
    end
  end  

  # PATCH/PUT /actions/:id
  def update
    authorize @action
    if @action.update(action_params)
      render json: @action
    else
      render json: @action.errors, status: :unprocessable_entity
    end
  end

  # DELETE /actions/:id
  def destroy
    authorize @action
    @action.destroy
    head :no_content
  end


  private

  def set_action
    @action = Action.find(params[:id])
  end

  def action_params
    # cambie el requide de :action a :play porque action es una palabra reservada de rails, debo de cambiar todo lo que se llama actions por plays
    params.require(:play).permit(:match_id, :player_id, :action_type, :timestamp, :section, :quarter, :assisted_by_player_id, :fouled_player_id)
  end
end


