module Mutations
  class CreateProject < BaseMutation
    argument :name, String, required: true
    argument :summary, String, required: true
    argument :mod_number, String, required: true
    argument :owner_id, ID, required: true

    field :project, Types::ProjectType, null: true
    field :errors, [String], null: false

    def resolve(info)
      if Project.create!(
        name: info[:name],
        summary: info[:summary],
        mod_number: info[:mod_number],
        owner: User.find(info[:owner_id])
        )
        Collaborator.create!(user_id: info[:owner_id], project_id: Project.last.id)
        return_info(Project.last, errors: [])
      end
    rescue ActiveRecord::RecordInvalid => error
      return_info(nil, errors: error)
      # send back error if project not created
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
