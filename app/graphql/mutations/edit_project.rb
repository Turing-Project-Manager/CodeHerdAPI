module Mutations
  class EditProject < BaseMutation
    argument :user_id, ID, required: true
    argument :project_id, ID, required: true
    argument :summary, String, required: false
    argument :name, String, required: false
    argument :mod_number, String, required: false

    field :project, Types::ProjectType, null: true
    field :errors, [String], null: false

    def resolve(info)
      if Collaborator.where(user_id: info[:user_id], project_id: info[:project_id]).any?
        info.delete(:user_id)
        project_id = info.delete(:project_id)
        project = Project.find(project_id)
        if project.update(info)
          return_info(project, errors: [])
        # we currently do not have any sad paths or edge cases that use this else
        # else
        #   return_info(nil, errors: project.errors.full_messages)
        end
      else
        return_info(nil, errors: ["Please give a valid user id and project id."])
      end
    end

    private
    def return_info(project, errors: [])
      {
        project: project,
        errors: errors
      }
    end
  end
end
