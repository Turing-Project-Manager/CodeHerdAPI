module Types
  class ResourceType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :tags, [String], null: true
    field :project, Types::ProjectType, null: true
  end
end
