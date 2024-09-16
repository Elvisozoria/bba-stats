# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Cambia '*' por el dominio de tu frontend en producción

    resource '*',
      headers: :any,
      expose: ['Authorization'], # Permite que el cliente pueda acceder a la cabecera 'Authorization'
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: false
  end
end
