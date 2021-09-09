# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
#     origins ENV['CORS_ORIGINS']
    origins 'http://localhost:3000', 'https://codeherd.herokuapp.com'

    resource '/graphql', headers: :any, methods: %i[post delete options head]
    resource '/auth/github', headers: :any, methods: [:get]
  end
end
