# app/controllers/sessions_controller.rb

class SessionsController < Devise::SessionsController
  respond_to :json

  # POST /users/sign_in
  def create
    user = User.find_by(email: sign_in_params[:email])

    if user&.valid_password?(sign_in_params[:password])
      sign_in(user)
      token = response.headers['Authorization']
      render json: { message: 'Inicio de sesión exitoso', user: user }, status: :ok, headers: { 'Authorization' => token }

    else
      render json: { error: 'Correo o contraseña inválidos' }, status: :unauthorized
    end
  end

  # DELETE /users/sign_out
  def destroy
    sign_out(current_user)
    render json: { message: 'Sesión cerrada correctamente' }, status: :ok
  end

  private

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end
