module Types
  class MutationType < Types::BaseObject
    field :create_collaboration, mutation: Mutations::CreateCollaboration
    field :create_project, mutation: Mutations::CreateProject
    field :create_project_repo, mutation: Mutations::CreateProjectRepo
    field :create_resource, mutation: Mutations::CreateResource
    field :delete_project_repo, mutation: Mutations::DeleteProjectRepo
    field :delete_resource, mutation: Mutations::DeleteResource
    field :edit_project, mutation: Mutations::EditProject
    field :edit_resource, mutation: Mutations::EditResource
    field :edit_user, mutation: Mutations::EditUser
    field :delete_collaborator, mutation: Mutations::DeleteCollaborator
    # TODO: remove me
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World"
    # end
  end
end
