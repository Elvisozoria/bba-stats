Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions'
  }
  resources :teams
  resources :players
  resources :matches
  resources :actions
  resources :users, only: [:index, :show, :update, :destroy]

  get '/matches/:id/score', to: 'matches#get_match_score'

  devise_scope :user do
    get '/validate_token', to: 'devise/sessions#validate_token'
  end
  
  # Ruta para la salud del servidor
  get '/health', to: proc { [200, {}, ['OK']] }

  root to: "home#index"

end
# app/controllers/users/sessions_controller.rb
