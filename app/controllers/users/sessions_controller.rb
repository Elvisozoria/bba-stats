# app/controllers/users/sessions_controller.rb

class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!, only: [:validate_token]

  def validate_token
    render json: { valid: true, user: current_user }, status: :ok
  rescue
    render json: { valid: false }, status: :unauthorized
  end
end
