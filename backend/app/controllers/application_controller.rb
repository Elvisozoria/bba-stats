# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include Pundit
  include Rails.application.routes.url_helpers

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    binding.pry
    render json: { error: 'No estás autorizado para realizar esta acción.' }, status: :forbidden
  end
end
