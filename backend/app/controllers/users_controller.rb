# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = policy_scope(User).includes(:player)
    render json: @users, include: [:player]
  end

  # GET /users/:id
  def show
    authorize @user
    render json: @user, include: [:player]
  end

  # POST /users
  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/:id
  def update
    authorize @user
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    authorize @user
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    # Para crear un usuario, asegúrate de incluir los campos necesarios
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :role, :player_id)
  end
end
