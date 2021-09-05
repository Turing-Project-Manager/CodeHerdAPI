module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World!"
    # end

    field :users, [Types::UserType], null: false,
      description: "return all users"

    def users
      User.all
    end

    field :user, Types::UserType, null: false do
      description "return a user"
      argument :id, ID, required: true, description: "ID of the user you want to find"
    end

    def user(id:)
      User.find(id)
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end

    field :users_projects, [Types::ProjectType], null: false do
      description "all of a user's projects"
      argument :user_id, ID, required: true, description: "ID of the user you want to find projects for"
    end

    def users_projects(user_id:)
      Project.where(owner_id: user_id)
    end

    field :project, Types::ProjectType, null: false do
      description "Get project by ID"
      argument :id, ID, required: true, description: "ID of the project you want to find"
    end

    def project(id:)
      Project.find(id)
    end
  end
end
