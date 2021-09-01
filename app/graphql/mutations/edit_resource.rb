module Mutations
  class EditResource < BaseMutation
    argument :user_id, ID, required: true
    argument :project_id, ID, required: true
    argument :resource_id, ID, required: true
    argument :name, String, required: true
    argument :resource_type, String, required: true
    argument :content, String, required: true
    argument :tags, [String], required: true

    field :resource, Types::ResourceType, null: true
    field :errors, [String], null: false

    # user must be collaborator on project
    # return the resource if it was created
    # return the errors if the resource was not created
    # remove from hash fields that are empty or blank

    def resolve(info)
      attrs = info.except(:user_id, :project_id, :resource_id)
      if Collaborator.where(user_id: info[:user_id], project_id: info[:project_id]).empty?
        return return_info(nil, errors: ['Cant edit resource. You are not a collaborator or project doesnt exist'])
      end

      resource = Resource.find(info[:resource_id])
      # attrs[:tags] ||= resource.tags
      
      if resource.update(attrs)
        return_info(resource)
      else
        return_info(nil, errors: resource.errors.full_messages)
      end
    rescue ArgumentError => error
      return_info(nil, errors: [error.message])
    end

    private
    def return_info(resource, errors: [])
      {
        resource: resource,
        errors: errors
      }
    end
  end
end
