module Mutations
  class DeleteProjectRepo < BaseMutation
    argument :user_id, ID, required: true
    argument :project_id, ID, required: true
    argument :repo_name, ID, required: true

    field :errors, [String], null: false


    def resolve(user_id:, project_id:, repo_name:)
      is_collaborator = Collaborator.find_by(user_id: user_id, project_id: project_id)
      if is_collaborator
        project_repo = ProjectRepo.where(project_id: project_id, repo_name: repo_name).first
        if project_repo
          project_repo.destroy
          { errors: [] }
        else
          { errors: ['could not find project repo'] }
        end
          
      else
        { errors: ['Project does not exist or the user is not a collaborator'] }
      end
    end
  end
end
