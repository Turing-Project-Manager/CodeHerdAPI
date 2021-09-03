module Mutations
  class CreateProjectRepo < BaseMutation
    argument :user_id, ID, required: true
    argument :project_id, ID, required: true
    argument :repo_name, ID, required: true

    field :errors, [String], null: false
    field :project_repo, Types::ProjectRepoType, null: true
    # user must be collaborator on project
    # return the repo if it was created
    # return the errors if the repo was not created

    def resolve(user_id:, project_id:, repo_name:)
      is_collaborator = Collaborator.find_by(user_id: user_id, project_id: project_id)
      if is_collaborator
        project = Project.find(project_id)
        user = User.find(user_id)
        project_repo = ProjectRepo.new(project: project, repo_name: repo_name)
        if project_repo.save
          return_info(project_repo)
        else
          return_info(nil, errors: project_repo.errors.full_messages)
        end
          
      else
        return_info(nil, errors: ['Project does not exist or the user is not a collaborator'])
      end
    end

    private
    def return_info(project_repo, errors: [])
      {
        project_repo: project_repo,
        errors: errors
      }
    end
  end
end
