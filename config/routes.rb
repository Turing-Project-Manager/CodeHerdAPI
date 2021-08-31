Rails
  .application
  .routes
  .draw do
    #mounts GraphiQL engine to the /graphiql path and directs queries to the execute method in the graphql controller
    if Rails.env.development?
      mount GraphiQL::Rails::Engine,
            at: '/graphiql',
            graphql_path: 'graphql#execute'
    end

    post '/graphql', to: 'graphql#execute'

    get 'sessions/new', as: :sign_in

    get '/auth/:provider/callback', to: 'sessions#create'
  end
