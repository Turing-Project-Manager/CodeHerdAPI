module Types
  class ResourceType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :resource_type, String, null: false
    field :tags, [String], null: true
    field :content, String, null: false
    field :project, Types::ProjectType, null: true
  end
end
