Rails.application.routes.draw do
  #mounts GraphiQL engine to the /graphiql path and directs queries to the execute method in the graphql controller
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: 'graphql#execute'
  end

  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
