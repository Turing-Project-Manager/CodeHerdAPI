module Mutations
  class DeleteCollaborator < BaseMutation
    argument :user_id, ID, required: true
    argument :project_id, ID, required: true
    argument :collaborator, String, required: true

    field :errors, [String], null: false


    def resolve(info)
      is_collaborator = Collaborator.find_by(user_id: info[:user_id], project_id: info[:project_id])
      if is_collaborator
        user_to_remove = User.find_by(name: info[:collaborator]).id
        collaboration = Collaborator.find_by(project_id: info[:project_id], user_id: user_to_remove)
        if collaboration
          collaboration.destroy
          { errors: [] }
        else
          { errors: ['Could not find this collaboration'] }
        end

      else
        { errors: ['Project does not exist or the user is not a collaborator'] }
      end
    end
  end
end
