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
        return_info(Project.last, errors: [])
      else
        return_info(nil, errors: ["Some or all of this info was invalid. Sorry this is a bad error message."])
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
