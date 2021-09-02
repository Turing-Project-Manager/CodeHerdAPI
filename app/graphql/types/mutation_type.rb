module Types
  class MutationType < Types::BaseObject
    field :edit_user, mutation: Mutations::EditUser
    field :edit_project, mutation: Mutations::EditProject
    field :create_project, mutation: Mutations::CreateProject

    # TODO: remove me
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World"
    # end
  end
end
