module Types
  class ProjectType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :summary, String, null: true
    field :mod_number, String, null: true
    field :owner, Types::UserType, null: true
    field :collaborators, [Types::CollaboratorType], null: true
    field :resources, [Types::ResourceType], null: true
    field :project_repo, Types::ProjectRepoType, null: true
  end
end
