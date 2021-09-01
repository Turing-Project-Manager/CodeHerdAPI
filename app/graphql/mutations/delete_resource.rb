module Mutations
  class DeleteResource < BaseMutation
    argument :user_id, ID, required: true
    argument :project_id, ID, required: true
    argument :resource_id, ID, required: true

    field :errors, [String], null: false

    # user must be collaborator on project
    # return the resource if it was created
    # return the errors if the resource was not created
    # remove from hash fields that are empty or blank

    def resolve(user_id:, project_id:, resource_id:)
      if Collaborator.where(user_id: user_id, project_id: project_id).empty?
        return {errors: ['Cant delete resource. You are not a collaborator or project doesnt exist']}
      end
      resource = Resource.find(resource_id).destroy
      {errors: []}
    rescue ActiveRecord::RecordNotFound
      {errors: ['Resource not found']}
    end
  end
end
