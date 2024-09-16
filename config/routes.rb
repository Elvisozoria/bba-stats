Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions'
  }
  resources :teams
  resources :players
  resources :matches
  resources :actions
  resources :users, only: [:index, :show, :update, :destroy]
  
  # Ruta para la salud del servidor
  get '/health', to: proc { [200, {}, ['OK']] }

  root to: "home#index"

end
