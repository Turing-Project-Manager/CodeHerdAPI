module Mutations
  class CreateCollaboration < BaseMutation
    argument :user_id, ID, required: true
    argument :email, String, required: true
    argument :project_id, ID, required: true

    field :collaborator, Types::CollaboratorType, null: true
    field :errors, [String], null: false

    def resolve(info)
      if find_collaborator(info) || find_project(info)
        collaborator = User.find_by(email: info[:email])
        if Collaborator.create!(user: collaborator, project_id: info[:project_id])
          return_info(Collaborator.last, errors: [])
        end
      end
    rescue ActiveRecord::RecordInvalid => error
      return_info(nil, errors: ["#{error.message}"])
    end


    private
    def find_collaborator(info)
      Collaborator.find_by(user_id: info[:user_id], project_id: info[:project_id])
    end

    def find_project(info)
      Project.find_by(owner_id: info[:user_id], id: info[:project_id])
    end

    def return_info(collaborator, errors: [])
      {
        collaborator: collaborator,
        errors: errors
      }
    end
  end
end
