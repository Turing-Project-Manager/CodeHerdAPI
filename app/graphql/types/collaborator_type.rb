module Types
  class CollaboratorType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: true
    field :project, Types::ProjectType, null: true
  end
end
