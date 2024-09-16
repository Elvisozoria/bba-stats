# app/controllers/teams_controller.rb
class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :update, :destroy]

  # GET /teams
  def index
    @teams = policy_scope(Team)
    render json: @teams, include: [:logo]
  end

  # GET /teams/:id
  def show
    authorize @team
    render json: @team, include: [:logo]
  end

  # POST /teams
  def create
    @team = Team.new(team_params)
    authorize @team

    if @team.save
      render json: @team, status: :created, location: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teams/:id
  def update
    authorize @team
    if @team.update(team_params)
      render json: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teams/:id
  def destroy
    authorize @team
    @team.destroy
    head :no_content
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :logo)
  end
end
