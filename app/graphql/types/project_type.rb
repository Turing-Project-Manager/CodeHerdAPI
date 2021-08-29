module Types
  class ProjectType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :summary, String, null: true
    field :mod_number, String, null: true
    field :owner, Types::UserType, null: true
  end
end
