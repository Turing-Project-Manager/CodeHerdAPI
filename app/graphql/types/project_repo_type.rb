module Types
  class ProjectRepoType < Types::BaseObject
    field :id, ID, null: false
    field :repo_name, String, null: true
    field :project, Types::ProjectType, null: true
  end
end
